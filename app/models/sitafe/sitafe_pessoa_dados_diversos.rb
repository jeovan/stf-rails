class Sitafe::SitafePessoaDadosDiversos < ApplicationRecord
	
	belongs_to :sitafe_pessoa, foreign_key: 'tuk', primary_key: 'tuk'

	self.table_name = 'SITAFE.SITAFE_PESSOA_DADOS_DIVERSOS'
	self.primary_key = 'tuk'
	
	def initialize(options = {})
		super

		if self.m_occurs == 0
			last_m_occurs_of_tuk = Sitafe::SitafePessoaDadosDiversos.where(tuk: self.tuk).last

			if last_m_occurs_of_tuk == nil
				last_m_occurs_of_tuk = 1
			else
				last_m_occurs_of_tuk = last_m_occurs_of_tuk.m_occurs + 1
			end

			self.m_occurs = last_m_occurs_of_tuk
		end
	end
			
	
end