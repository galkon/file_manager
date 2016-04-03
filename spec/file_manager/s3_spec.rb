require 'spec_helper'

RSpec.describe FileManager::S3 do
  let(:file_path)   { "foo/bar.json" }
  let(:bucket_name) { "bucket" }
  let(:resource)    { double(Aws::S3::Resource) }
  let(:bucket)      { double(Aws::S3::Bucket) }
  let(:object)      { double(Aws::S3::Object) }

  before do
    allow(Aws::S3::Resource).to receive(:new) { resource }
    allow(resource).to receive(:bucket) { bucket }

    allow(bucket).to receive(:object) { object }
    allow(bucket).to receive(:to_sym) { :bucket }

    allow(object).to receive(:to_sym) { :object }
  end

  describe ".store" do
    let(:file) { File.new(__FILE__) }

    subject { described_class.store(file_path: file_path, file: file, bucket: bucket_name) }

    before do
      allow(object).to receive(:put)
      subject
    end

    it "uploads the object with the contents of the file and an acl of private" do
      expect(object).to have_received(:put).with({acl: "private", body: file})
    end

    context "public acl passed" do
      subject { described_class.store(file_path: file_path, file: file, bucket: bucket_name, acl: "public") }

      it "uploads the object with the contents of the file and an acl of public" do
        expect(object).to have_received(:put).with({acl: "public", body: file})
      end
    end
  end

  describe ".delete" do
    subject { described_class.delete(file_path: file_path, bucket: bucket_name)  }

    before do
      allow(object).to receive(:delete)
      subject
    end

    it "deletes the object" do
      expect(object).to have_received(:delete)
    end
  end
end