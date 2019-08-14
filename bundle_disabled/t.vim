scorecard_id = 26

require 'csv'

class MakeCSV
  attr_reader :scorecard

  def initialize(scorecard_id)
    @scorecard = Scorecard.find scorecard_id
    create
  end

  def create
    CSV.open("#{Rails.root}/tmp/file.csv", "wb") do |csv|
      csv << ["Skills Development"]
      csv << headers 
      fetch_rows.each { |row| csv << row }
    end
  end

  def headers
    [
      "Training Program Name *",
      "Category *",
      "ABET",
      "Mandatory Training?",
      ("Bursary or Scholarship?" if construction_fields? and scorecard.generic?),
      ("Tourism related" if tourism_fields?),
      "Training Provider",
      "Province",
      "Municipality",
      "Learner Name *",
      ("Management level *" if financial_fields?),
      "ID Number",
      "Gender *",
      "Race *",
      "Disabled?",
      "Foreign?",
      ("Office based?" if construction_fields?),
      ("Management Position" if construction_fields?),
      "Age",
      "Employed?",
      "Completed?",
      "Absorbed?",
      "Course Cost",
      "Travel Cost",
      "Accommodation Cost",
      "Catering Cost",
      "Stationery Cost",
      "Training Facility Cost",
      "Salary Cost (category B,C,D only)",
      "Other Costs",
      "Start Date (format: dd/mm/yyyy)",
      "End Date (format: dd/mm/yyyy)",
      "Custom Data",
      "Man hours",
      "Location",
      "Business Unit",
      "Employee Code"
    ].compact
  end

  def fetch_rows
    [].tap do |row|
      scorecard.bravo_skills_development.participants.each do |p|
        row << generate_row(p)
      end
    end
  end

  def generate_row(participant)
    data = [
      participant.training_program.name,
      participant.training_program.category,
      participant.training_program.abet?.to_yes_no,
      participant.training_program.mandatory?.to_yes_no,
      participant.training_program.training_provider,
      participant.training_program.province.try(:as_province_description),
      participant.training_program.municipality,
      participant.full_name,
      participant.id_number,
      participant.gender,
      participant.race,
      participant.disabled?.to_yes_no,
      participant.foreign?.to_yes_no,
      participant.age.try(:as_age_group_description),
      participant.employed.to_yes_no,
      participant.completed.to_yes_no,
      participant.absorbed.to_yes_no,
      participant.course_cost,
      participant.travel_cost,
      participant.accommodation_cost,
      participant.catering_cost,
      participant.stationery_cost,
      participant.training_facility_cost,
      participant.salary_cost,
      participant.other_costs,
      participant.start_date.andand.strftime("%d/%m/%Y"),
      participant.end_date.andand.strftime("%d/%m/%Y"),
      participant.custom_data,
      participant.man_hours,
      participant.location,
      participant.business_unit,
      participant.employee_code
    ]

    data.insert(8, participant.position) if financial_fields?
    data.insert(4, participant.training_program.is_tourism_related_expenditure.to_yes_no) if tourism_fields?

    if construction_fields?
      if scorecard.generic?
        data.insert(4, participant.training_program.scholarship.to_yes_no)
        data.insert(14, participant.office_based.to_yes_no)
        data.insert(15, participant.position)
      else
        data.insert(13, participant.office_based.to_yes_no)
        data.insert(14, participant.position)
      end
    end

    data
  end

  def tourism_fields?
    scorecard.charter_is?(:bravo_tourism) and scorecard.generic?
  end
  
  def financial_fields?
    scorecard.bravo_financial? and scorecard.generic?
  end
  
  def construction_fields?
    scorecard.charter_is?(:bravo_construction_contractors, :bravo_construction_built_environment_professionals)
  end
end

MakeCSV.new(scorecard_id)
