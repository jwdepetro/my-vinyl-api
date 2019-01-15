module V1
    class TracksController < ApplicationController
        before_action :set_record
        before_action :set_track, only: [:show, :update, :destroy]

        # GET /records/:id/tracks
        def index
            json_response(@record.tracks)
        end

        # GET /records/:id/tracks/:id
        def show
            json_response(@track)
        end

        # POST /records/:id/tracks
        def create
            @record.tracks.create!(track_params)
            json_response(@record, :created)
        end

        # PUT /records/:id/tracks/:id
        def update
            @track.update!(track_params)
            head :no_content
        end

        # DELETE /records/:id/tracks/:id
        def destroy
            @track.destroy
            head :no_content
        end

        private

        def track_params
            params.permit(:name, :number, :duration)
        end

        def set_record
            @record = Record.find(params[:record_id])
        end

        def set_track
            @track = @record.tracks.find_by!(id: params[:id]) if @record
        end
    end
end
