module Modules
  module Validator
    def validate(validation_rules)
      validation_results = {}

      puts validation_rules

      validation_rules.each do |field, rules|
        invalid = []
        rules.each do |rule|
          case rule
          when :required
            invalid.push "#{field} is required" if params[field].nil? || params[field].empty?
          when :number
            invalid.push "#{field} must be a number" unless params[field].to_s.match?(/\A\d+\Z/)
          when :email
            invalid.push "#{field} must be a valid email" unless params[field].to_s.match?(/\A[^@\s]+@[^@\s]+\z/)
          when :boolean
            invalid.push "#{field} must be a boolean" unless [ true, false ].include?(params[field])
          when Hash
            if rule.key?(:length)
              min_length = rule[:length][:min] || 0
              max_length = rule[:length][:max] || Float::INFINITY
              length = params[field].to_s.length
              invalid.push "#{field} must be at least #{min_length} characters" if length < min_length
              invalid.push "#{field} must be at most #{max_length} characters" if length > max_length
            end
          end

          validation_results[field] = invalid if invalid.any?
        end
      end

      validation_results
    end
  end
end
