class Sitafe::SitafeVeiculo < ApplicationRecord
	
	has_many :sitafe_veiculo_co_erro, foreign_key: 'tuk', primary_key: 'tuk', dependent: :delete_all
	
	self.table_name = 'SITAFE.SITAFE_VEICULO'
	self.sequence_name = 'SITAFE.SEQ_SITAFE_VEICULO'
	self.primary_key = 'tuk'
	
	
	
	validates_uniqueness_of :sp_devedor_placa, allow_nil: true
	
	after_find do |sitafe_veiculo|
    sitafe_veiculo.attribute_names.each do |name|
      self.class.send(:define_method, "#{name}") do
        if !read_attribute(:"#{name}").nil? && read_attribute(:"#{name}").class == String
          read_attribute(:"#{name}").encode('UTF-8', 'Windows-1252', invalid: :replace, undef: :replace, replace: '?')
        else
          read_attribute(:"#{name}")
        end
      end
    end
  end
  
  before_save do |sitafe_veiculo|
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
		
		if fields_empty? [self.gr_composicao, self.it_co_marca_modelo, self.it_da_ano_fabricacao]
			self.sp_composicao_modelo_fab = nil
		else
			self.sp_composicao_modelo_fab = "#{self.gr_composicao.to_s[0..8].ljust(9)}#{self.it_co_marca_modelo.to_s[0..5].ljust(6)}#{self.it_da_ano_fabricacao.to_s[0..3]}"
		end

		if fields_empty? [self.it_da_entrada_frota, self.it_co_renavam]
			self.sp_da_frota_renavam = nil
		else
			self.sp_da_frota_renavam = "#{self.it_da_entrada_frota.to_s[0..7].ljust(8)}#{self.it_co_renavam.to_s[0..10]}"
		end

		if fields_empty? [self.it_da_emissao_nota_fiscal, self.it_co_renavam]
			self.sp_da_nf_renavam = nil
		else
			self.sp_da_nf_renavam = "#{self.it_da_emissao_nota_fiscal.to_s[0..7].ljust(8)}#{self.it_co_renavam.to_s[0..10]}"
		end

		if fields_empty? [self.it_nu_devedor, self.it_nu_placa]
			self.sp_devedor_placa = nil
		else
			self.sp_devedor_placa = "#{self.it_nu_devedor.to_s[0..13].ljust(14)}#{self.it_nu_placa.to_s[0..6]}"
		end

		if fields_empty? [self.it_nu_devedor, self.it_co_renavam]
			self.sp_devedor_renavam = nil
		else
			self.sp_devedor_renavam = "#{self.it_nu_devedor.to_s[0..13].ljust(14)}#{self.it_co_renavam.to_s[0..10]}"
		end

		if fields_empty? [self.it_co_motivo_isencao, self.it_co_municipio_corresp, self.it_co_renavam]
			self.sp_isencao_mun_renavam = nil
		else
			self.sp_isencao_mun_renavam = "#{self.it_co_motivo_isencao.to_s[0..1].ljust(2)}#{self.it_co_municipio_corresp.to_s[0..5].ljust(6)}#{self.it_co_renavam.to_s[0..10]}"
		end

		if fields_empty? [self.it_co_motivo_isencao, self.it_co_renavam]
			self.sp_isencao_renavam = nil
		else
			self.sp_isencao_renavam = "#{self.it_co_motivo_isencao.to_s[0..1].ljust(2)}#{self.it_co_renavam.to_s[0..10]}"
		end

		if fields_empty? [self.it_co_municipio_corresp, self.gr_composicao, self.it_co_renavam]
			self.sp_muni_composicao = nil
		else
			self.sp_muni_composicao = "#{self.it_co_municipio_corresp.to_s[0..5].ljust(6)}#{self.gr_composicao.to_s[0..8].ljust(9)}#{self.it_co_renavam.to_s[0..10]}"
		end

	end
	
end