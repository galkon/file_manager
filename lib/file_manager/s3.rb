require "aws-sdk-resources"

module FileManager
  class S3
    class << self
      def store(file_path:, file:, bucket:, acl: "private")
        new(file_path: file_path, file: file, bucket: bucket, acl: acl).store
      end

      def delete(file_path:, bucket:)
        new(file_path: file_path, bucket: bucket).delete
      end
    end

    def store
      object.put({acl: @acl, body: @file})
    end

    def delete
      object.delete if @file_path
    end

    private

    def initialize(options = {})
      # Mandatory options
      @file_path = options.fetch(:file_path)
      @bucket = options.fetch(:bucket)

      # Optional options
      @file = options[:file]
      @acl = options[:acl]
    end

    def object
      bucket.object(@file_path)
    end

    def bucket
      get_bucket_by(name: @bucket)
    end

    def get_bucket_by(name:)
      resource.bucket(name)
    end

    def resource
      @resource ||= Aws::S3::Resource.new
    end
  end
end
