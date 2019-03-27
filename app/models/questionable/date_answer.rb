module Questionable
  class DateAnswer
    include ActiveModel::Validations

    attr_accessor :month, :day, :year

    validates :month, :day, :year, presence: true
    validate :is_date

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def to_s
      "#{year}-#{month}-#{day}"
    end

    def empty?
      !(month.present? || day.present? || year.present?)
    end

    private

    def is_date
      to_s.try(:to_date)
    rescue ArgumentError
      errors.add(:base, 'Date is invalid')
    end
  end
end
