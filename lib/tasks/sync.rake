task sync: :environment do
  zip_url = ENV.fetch('ZIP_URL')
  data_dir = Rails.root.join('tmp/csvs/')
  unless Dir.exist?(data_dir.to_s)
    FileUtils.mkdir_p(data_dir.to_s)
  end

  Tempfile.open do |tmp_file|
    `wget "#{zip_url}" -O #{tmp_file.path}`
    Dir.mktmpdir do |temp_dir|
      `unzip #{tmp_file.path} -d #{temp_dir}`
      `cp #{temp_dir}/csvs/* #{data_dir}`
    end
  end
end
