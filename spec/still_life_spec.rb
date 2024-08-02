require 'spec_helper'
require 'fileutils'

RSpec.describe StillLife do
  STILL_LIFE_ENV_VAR = 'spec'

  def dump_dir(file)
    "#{Dir.pwd}/tmp/html/#{STILL_LIFE_ENV_VAR}/spec/#{file}.html"
  end

  around do |e|
    Dir.chdir "#{__dir__}/../test/dummy_app" do
      FileUtils.rm_rf 'tmp/html/'

      e.run
    end
  end

  specify do
    system "RAILS_VERSION=#{ENV['RAILS_VERSION']} STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e rspec spec/controllers/ spec/requests/"

    expect(File).to exist(dump_dir("controllers/users_controller_spec.rb-105"))
    expect(File).to exist(dump_dir("controllers/users_controller_spec.rb-112"))
    expect(File).to exist(dump_dir("controllers/users_controller_spec.rb-130"))
    expect(File).to exist(dump_dir("controllers/users_controller_spec.rb-136"))
    expect(File).to exist(dump_dir("controllers/users_controller_spec.rb-79"))
    expect(File).to exist(dump_dir("controllers/users_controller_spec.rb-84"))
    expect(File).to exist(dump_dir("requests/users_spec.rb-6"))

    system "RAILS_VERSION=#{ENV['RAILS_VERSION']} STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e bin/rails spec:system"

    expect(File).to exist(dump_dir("system/users_spec.rb-11"))
    expect(File).to exist(dump_dir("system/users_spec.rb-16"))
    expect(File).to exist(dump_dir("system/users_spec.rb-17"))
    expect(File).to exist(dump_dir("system/users_spec.rb-20"))
    expect(File).to exist(dump_dir("system/users_spec.rb-23"))
    expect(File).to exist(dump_dir("system/users_spec.rb-27"))
    expect(File).to exist(dump_dir("system/users_spec.rb-28"))
    expect(File).to exist(dump_dir("system/users_spec.rb-31"))
    expect(File).to exist(dump_dir("system/users_spec.rb-34"))
    expect(File).to exist(dump_dir("system/users_spec.rb-38"))
    expect(File).to exist(dump_dir("system/users_spec.rb-39"))
  end
end
