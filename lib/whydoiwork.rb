require "yaml"
require "harvested"
require "active_support/core_ext/date"
require "active_support/core_ext/time"

require "whydoiwork/version"

module Whydoiwork
  def self.run
    unless config_file_exists?
      puts "Config file #{config_file_name} created."
      File.write(config_file_name, config_sample)
      exit 1
    end

    money = (total_time_from_harvest * config["rate"]).round

    config["expenses"].each_pair do |name, cost|
      if money > cost
        puts "#{name} (#{cost})… done"
      elsif money > 0
        puts "#{name} (#{cost})… earning right now"
      else
        puts "#{name} (#{cost})"
      end
      money -= cost
    end

    if money > 0
      puts "Free to spend: #{money}"
    end
  end

  def self.config
    @config ||= YAML.load_file(config_file_name)
  end

  def self.config_file_exists?
    File.exists?(config_file_name)
  end

  def self.config_file_name
    File.expand_path("~/.whydoiwork.yml")
  end

  def self.config_sample
    <<-YAML
harvest:
  subdomain:
  username:
  password:
rate:
expenses:
  rent: 800
  food: 1000
  car:  250
    YAML
  end

  def self.total_time_from_harvest
    user_id = harvest.account.who_am_i.id
    time_entries = harvest.reports.time_by_user(user_id, Date.today.beginning_of_month, Date.today.end_of_month)
    time_entries.map(&:hours).inject(0, &:+)
  end

  def self.harvest
    @harvest ||= Harvest.client(config["harvest"]["subdomain"], config["harvest"]["username"], config["harvest"]["password"])
  end
end
