class Sitafe::SitafeVeiculoCoErro < ApplicationRecord
	
	belongs_to :sitafe_veiculo, foreign_key: 'tuk', primary_key: 'tuk'

	self.table_name = 'SITAFE.SITAFE_VEICULO_CO_ERRO'
	self.primary_key = 'tuk'
	
	def initialize(options = {})
		super

		if self.m_occurs == 0
			last_m_occurs_of_tuk = Sitafe::SitafeVeiculoCoErro.where(tuk: self.tuk).last

			if last_m_occurs_of_tuk == nil
				last_m_occurs_of_tuk = 1
			else
				last_m_occurs_of_tuk = last_m_occurs_of_tuk.m_occurs + 1
			end

			self.m_occurs = last_m_occurs_of_tuk
		end
	end
			
	
	
	
	after_find do |sitafe_veiculo_co_erro|
    sitafe_veiculo_co_erro.attribute_names.each do |name|
      self.class.send(:define_method, "#{name}") do
        if !read_attribute(:"#{name}").nil? && read_attribute(:"#{name}").class == String
          read_attribute(:"#{name}").encode('UTF-8', 'Windows-1252', invalid: :replace, undef: :replace, replace: '?')
        else
          read_attribute(:"#{name}")
        end
      end
    end
  end
  
  before_save do |sitafe_veiculo_co_erro|
    supers
  end
	
	private

	def fields_empty?(fields)
		fields.each do |field|
			return true if field.to_s == nil || field.to_s.strip == ''
		end

		return false
	end
	
	def supers
		
		if fields_empty? [self.it_co_erro_veiculo, self.it_co_renavam]
			self.sp_co_erro_veiculo_renavam = nil
		else
			self.sp_co_erro_veiculo_renavam = "#{self.it_co_erro_veiculo.to_s[0..2].ljust(3)}#{self.it_co_renavam.to_s[0..10]}"
		end

		if fields_empty? [self.it_co_renavam, self.it_co_erro_veiculo]
			self.sp_co_renavam_erro_veiculo = nil
		else
			self.sp_co_renavam_erro_veiculo = "#{self.it_co_renavam.to_s[0..10].ljust(11)}#{self.it_co_erro_veiculo.to_s[0..2]}"
		end

	end
	
end