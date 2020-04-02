namespace :eap do
  desc "Load EAP values for a year."
  task :load, [:year] => :environment do |_task, args|
    year      = args[:year].to_i
    data      = data_for_year(year)
    errors    = []
    success   = []

    ensure_all_regions_covered!(data)
    ensure_all_groups_covered!(data)

    data.each do |region, eap_data|
      eap = ProvincialEap.find_or_initialize_by_province_and_year(region, year)

      ProvincialEap::GROUPS.map(&:to_s).each do |group|
        eap.send("#{group}=", eap_data[group])
      end

      if eap.save
        success << region
      else
        errors << eap.errors.full_messages.to_sentence
      end
    end

    if errors.any?
      puts "\nThere were errors loading EAP data for #{year}."

      errors.each do |error|
        puts "   #{error}"
      end
    else
      puts "\nLoaded EAP data for #{2019} successfully for regions #{success.join(', ')}"
    end
  end

  desc "Check that all EAP data is there for a given year."
  task :check, [:year] => :environment do |_task, args|
    year      = args[:year].to_i
    data      = data_for_year(year)

    ensure_all_regions_covered!(data)
    ensure_all_groups_covered!(data)

    puts "\n\tEAP data for #{year} looks good."
  end

  desc "Show what will be added, doesnt write to the db"
  task :dry_run, [:year] => :environment do |_task, args|
    year      = args[:year].to_i
    data      = data_for_year(year)

    ensure_all_regions_covered!(data)
    ensure_all_groups_covered!(data)

    data.each do |region, eap_data|
      listing = data[region].map { |h| h.join(": ") }.join(", ")

      puts "\n#{region}"
      puts "\t#{listing}"
    end
  end
end


def ensure_all_groups_covered!(data)
  groups = ProvincialEap::GROUPS.map(&:to_s).sort

  data.each do |region, groups_per_region|
    this_regions_groups = groups_per_region.keys.uniq.sort

    all_ok = groups == this_regions_groups
    issues = (groups - this_regions_groups).join(', ')

    if !all_ok
      puts "\n\n\tYou are missing groups for region #{region}. Please check your data and try again\n\tStart here: #{issues}\n\n\n"
      exit
    end
  end

  true
end

def ensure_all_regions_covered!(data)
  provinces  = EAP_REGION_SELECT.flatten.uniq.sort
  my_regions = data.keys.sort
  all_ok     = my_regions == provinces
  issues     = (provinces - my_regions).join(', ')

  if !all_ok
    puts "\n\n\tYou are missing regions. Please check your data and try again\n\tStart here: #{issues}\n\n\n"
    exit
  end

  true
end

def data_for_year(year)
  data_file = Rails.root.join('db/seeds/provincial_eaps.yml')
  all_data  = YAML.load_file(data_file)
  this_year = all_data.select { |x| x["year"] == year }
  groups    = ProvincialEap::GROUPS.map(&:to_s)

  {}.tap do |data|
    this_year.each do |region|
      data[region["province"]] = {}
      data[region["province"]] = region.slice(*groups)
    end
  end
end

