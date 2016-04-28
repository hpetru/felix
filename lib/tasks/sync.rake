task sync: :environment do
  zip_url = ENV.fetch('ZIP_URL')
  data_dir = Rails.root.join('tmp/csvs/')

  Tempfile.open do |tmp_file|
    `wget "#{zip_url}" -O #{tmp_file.path}`
    Dir.mktmpdir do |temp_dir|
      `unzip #{tmp_file.path} -d #{temp_dir}`
      `cp #{temp_dir}/csvs/* #{data_dir}`
    end
  end
end
