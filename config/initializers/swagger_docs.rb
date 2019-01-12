include Swagger::Docs::ImpotentMethods

class Swagger::Docs::Config
    def self.base_api_controller 
        ActionController::API 
    end
end

# Swagger::Docs::Config.register_apis({
#     '1.0' => {
#         :api_extension_type => :json,
#         :api_file_path => 'public',
#         :base_path => ENV.fetch('HOST'),
#         # :clean_directory => true,
#         :base_api_controller => '',
#         :attributes => {
#             :info => {
#                 'title' => 'My Vinyl API',
#                 'description' => 'This is the API component for a simple application that can manage a user\'s record collection.',
#                 'contact' => 'jwdepetro@gmail.com'
#             }
#         }
#     }
# })