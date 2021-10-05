class Sitafe::SitafePessoa < ApplicationRecord
	
	has_many :sitafe_pessoa_dados_diversos, foreign_key: 'tuk', primary_key: 'tuk', dependent: :delete_all
	has_many :sitafe_pessoa_comentario, foreign_key: 'tuk', primary_key: 'tuk', dependent: :delete_all
	has_many :sitafe_pessoa_usu_comentario, foreign_key: 'tuk', primary_key: 'tuk', dependent: :delete_all
	
	self.table_name = 'SITAFE.SITAFE_PESSOA'
	self.sequence_name = 'SITAFE.SEQ_SITAFE_PESSOA'
	self.primary_key = 'tuk'
	
	
	self.attribute('it_in_ultima_situacao', :integer)
	
	validates_uniqueness_of :sp_ident_credenciada_ultima, allow_nil: true
	validates_uniqueness_of :sp_ident_grafica_ultimo, allow_nil: true
	validates_uniqueness_of :sp_ident_tecnico_ecf, allow_nil: true
	
	after_find do |sitafe_pessoa|
    sitafe_pessoa.attribute_names.each do |name|
      self.class.send(:define_method, "#{name}") do
        if !read_attribute(:"#{name}").nil? && read_attribute(:"#{name}").class == String
          read_attribute(:"#{name}").encode('UTF-8', 'Windows-1252', invalid: :replace, undef: :replace, replace: '?')
        else
          read_attribute(:"#{name}")
        end
      end
    end
  end
  
  before_save do |sitafe_pessoa|
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
		
		if fields_empty? [self.it_co_cep, self.it_in_ultima_situacao]
			self.sp_cep_ultimo = nil
		else
			self.sp_cep_ultimo = "#{self.it_co_cep.to_s[0..7].ljust(8)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.it_co_municipio, self.it_no_fantasia]
			self.sp_cod_muni_nome_fantasia = nil
		else
			self.sp_cod_muni_nome_fantasia = "#{self.it_co_municipio.to_s[0..5].ljust(6)}#{self.it_no_fantasia.to_s[0..49]}"
		end

		if fields_empty? [self.it_co_municipio, self.it_no_pessoa]
			self.sp_cod_muni_nome_pessoa = nil
		else
			self.sp_cod_muni_nome_pessoa = "#{self.it_co_municipio.to_s[0..5].ljust(6)}#{self.it_no_pessoa.to_s[0..99]}"
		end

		if fields_empty? [self.gr_numero_crc, self.it_in_ultima_situacao]
			self.sp_crc_ultimo = nil
		else
			self.sp_crc_ultimo = "#{self.gr_numero_crc.to_s[0..9].ljust(10)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.it_da_transacao, self.it_co_municipio, self.it_nu_inscricao_estadual, self.it_in_ultima_situacao]
			self.sp_data_mu_inscr_ultima = nil
		else
			self.sp_data_mu_inscr_ultima = "#{self.it_da_transacao.to_s[0..7].ljust(8)}#{self.it_co_municipio.to_s[0..5].ljust(6)}#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.gr_numero_crc, self.it_in_ultima_situacao]
			self.sp_ident_crc_ultimo = nil
		else
			self.sp_ident_crc_ultimo = "#{self.gr_identificacao.to_s[0..14].ljust(15)}#{self.gr_numero_crc.to_s[0..9].ljust(10)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_in_credenciada, self.it_in_ultima_situacao]
			self.sp_ident_credenciada_ultima = nil
		else
			self.sp_ident_credenciada_ultima = "#{self.gr_identificacao.to_s[0..14].ljust(15)}#{self.it_in_credenciada.to_s[0..0].ljust(1)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_in_grafica, self.it_in_ultima_situacao]
			self.sp_ident_grafica_ultimo = nil
		else
			self.sp_ident_grafica_ultimo = "#{self.gr_identificacao.to_s[0..14].ljust(15)}#{self.it_in_grafica.to_s[0..0].ljust(1)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_nu_inscricao_estadual, self.it_in_ultima_situacao]
			self.sp_ident_insc_ultimo = nil
		else
			self.sp_ident_insc_ultimo = "#{self.gr_identificacao.to_s[0..14].ljust(15)}#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_in_tecnico_ecf, self.it_in_ultima_situacao]
			self.sp_ident_tecnico_ecf = nil
		else
			self.sp_ident_tecnico_ecf = "#{self.gr_identificacao.to_s[0..14].ljust(15)}#{self.it_in_tecnico_ecf.to_s[0..0].ljust(1)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_in_ultima_situacao]
			self.sp_ident_ultimo = nil
		else
			self.sp_ident_ultimo = "#{self.gr_identificacao.to_s[0..14].ljust(15)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_in_soft_house, self.it_in_ultima_situacao]
			self.sp_indent_soft_ultimo = nil
		else
			self.sp_indent_soft_ultimo = "#{self.gr_identificacao.to_s[0..14].ljust(15)}#{self.it_in_soft_house.to_s[0..0].ljust(1)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.it_nu_inscricao_estadual, self.it_in_ultima_situacao]
			self.sp_inscricao_ultimo = nil
		else
			self.sp_inscricao_ultimo = "#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.it_co_municipio, self.it_co_bairro, self.it_co_logradouro, self.it_no_pessoa, self.it_nu_inscricao_estadual, self.it_in_ultima_situacao]
			self.sp_mbln_insc_ultimo = nil
		else
			self.sp_mbln_insc_ultimo = "#{self.it_co_municipio.to_s[0..5].ljust(6)}#{self.it_co_bairro.to_s[0..6].ljust(7)}#{self.it_co_logradouro.to_s[0..4].ljust(5)}#{self.it_no_pessoa.to_s[0..99].ljust(100)}#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.it_co_municipio, self.it_nu_inscricao_estadual, self.it_in_ultima_situacao]
			self.sp_municipio_insc_ultimo = nil
		else
			self.sp_municipio_insc_ultimo = "#{self.it_co_municipio.to_s[0..5].ljust(6)}#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.it_no_pessoa, self.it_in_ultima_situacao]
			self.sp_nome_ultimo = nil
		else
			self.sp_nome_ultimo = "#{self.it_no_pessoa.to_s[0..99].ljust(100)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.it_nu_fac, self.it_co_municipio, self.it_no_pessoa, self.it_nu_inscricao_estadual, self.it_in_ultima_situacao]
			self.sp_rmn_insc_ultimo = nil
		else
			self.sp_rmn_insc_ultimo = "#{self.it_nu_fac.to_s[0..2].ljust(3)}#{self.it_co_municipio.to_s[0..5].ljust(6)}#{self.it_no_pessoa.to_s[0..99].ljust(100)}#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.it_no_fantasia, self.it_in_ultima_situacao]
			self.sp_tipo_fantasia_ultimo = nil
		else
			self.sp_tipo_fantasia_ultimo = "#{self.it_no_fantasia.to_s[0..49].ljust(50)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_no_pessoa, self.gr_numero_crc, self.it_in_ultima_situacao]
			self.sp_tipo_nome_crc_ultimo = nil
		else
			self.sp_tipo_nome_crc_ultimo = "#{self.gr_identificacao.to_s[0..0].ljust(1)}#{self.it_no_pessoa.to_s[0..99].ljust(100)}#{self.gr_numero_crc.to_s[0..9].ljust(10)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_no_pessoa, self.it_in_ultima_situacao]
			self.sp_tipo_nome_ultimo = nil
		else
			self.sp_tipo_nome_ultimo = "#{self.gr_identificacao.to_s[0..0].ljust(1)}#{self.it_no_pessoa.to_s[0..99].ljust(100)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_in_credenciada, self.it_no_pessoa, self.it_in_ultima_situacao]
			self.sp_tp_creden_nome_ultima = nil
		else
			self.sp_tp_creden_nome_ultima = "#{self.gr_identificacao.to_s[0..0].ljust(1)}#{self.it_in_credenciada.to_s[0..0].ljust(1)}#{self.it_no_pessoa.to_s[0..99].ljust(100)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_in_tecnico_ecf, self.it_no_pessoa, self.it_in_ultima_situacao]
			self.sp_tp_tecnico_nome_ultimo = nil
		else
			self.sp_tp_tecnico_nome_ultimo = "#{self.gr_identificacao.to_s[0..0].ljust(1)}#{self.it_in_tecnico_ecf.to_s[0..0].ljust(1)}#{self.it_no_pessoa.to_s[0..99].ljust(100)}#{self.it_in_ultima_situacao.to_s[0..0]}"
		end

	end
	
end