module V1
    class RecordsController < ApplicationController
        before_action :set_record, only: [:show, :update, :destroy]

        # GET /records
        def index
            @records = current_user.records.paginate(page: params[:page], per_page: 20)
            json_response(@records)
        end

        # POST /records
        def create 
            @record = current_user.records.create!(record_params)
            json_response(@record, :created)
        end

        # GET /records/:id
        def show 
            json_response(@record)
        end

        # PUT /records/:id
        def update 
            @record.update(record_params)
            head :no_content
        end

        # DELETE /records/:id
        def destroy
            @record.destroy
            head :no_content
        end

        private

        def record_params
            # Whitelisted params
            params.permit(:artist, :album, :year_released, :year_printed, :condition)
        end

        def set_record
            # Set the record for show, update, and delete
            @record = Record.find(params[:id])
        end
    end
end