-- CREATE Function [dbo].[Aud_Mask]
-- (
--  @Value Decimal(27,10)
-- ,@Separator nVarChar(1) = ','
-- ,@Decimal as Integer = 2
-- ,@StrSpace nVarChar(1) = ''
-- ,@Lenght as Integer = 19
-- )
-- RETURNS VarChar(30)
-- As
-- Begin
-- 	Declare
-- 	 @WReturn VarChar(30)
-- 	,@WPos as integer
-- 	Set @WReturn = REPLACE(@Value,'.',@Separator)
-- 	Set @WPos = LEN(@WReturn)
-- 	If @Value = 0
-- 		Set @WReturn = '0';
-- 	Else
-- 		If CHARINDEX(@Separator, @WReturn) > 0
-- 			While @WPos > 1
-- 				Begin
-- 					If SUBSTRING(@WReturn,@WPos,1) <> '0'
-- 						BREAK;
-- 					Se

CREATE FUNCTION dbo.FormatDateDMA(@date DATETIME)
    RETURNS VARCHAR(8)
AS
BEGIN
    IF (@date IS NULL)
    RETURN ''
    ELSE
    RETURN REPLACE(CONVERT(VARCHAR(10), CONVERT(DATE, @date, 112), 103), '/', '')

    RETURN ''
END;

-- CREATE FUNCTION dbo.IsnullConvert(@valor SQL_VARIANT, @valorSeNulo VARCHAR)
--     RETURNS VARCHAR(8)
-- AS
-- BEGIN
--     return isnull(CONVERT(VARCHAR, @valor), @valorSeNulo)
-- END;


Select '1'                                                  as ID
     , '1'                                                  as ID_PAI
     , '0000'                                               as REG
     , 'LECF'                                               as NOME_ESC
    /* confirmar a versão */
     , isnull(eecf.cod_ver, '0009')                         as COD_VER
     , isnull(estm.CNPJ, '')                                as CNPJ
     , isnull(estm.NOME, '')                                as NOME
     , isnull(eecf.IND_SIT_INI_PER, '0')                    as IND_SIT_INI_PER
     , isnull(eecf.SIT_ESPECIAL, '0')                       as SIT_ESPECIAL
     , dbo.Aud_Mask(abs(eecf.PAT_REMAN_CIS), ',', 4, '', 8) as PAT_REMAN_CIS
     , dbo.FormatDateDMA(eecf.DT_SIT_ESP)                   as DT_SIT_ESP
     , dbo.FormatDateDMA(eecf.PERIODO_DTINI)                as DT_INI
     , dbo.FormatDateDMA(eecf.PERIODO_DTFIN)                as DT_FIN
    /* --Em caso de nulo, deve retornar N? */
     , isnull(eecf.RETIFICADORA, 'N')                       as RETIFICADORA
     , isnull(eecf.NUM_REC, '')                             as NUM_REC
    /* --Em caso de nulo, deve retornar 0? */
     , isnull(eecf.TIP_ECF, '0')                            as TIP_ECF
     , isnull(eecf.COD_SCP, '')                             as COD_SCP
from estabelecimento_ecf eecf
         inner Join estabelecimentos estm
                    on estm.estabelecimento_id = eecf.estabelecimento_matriz_id
/* o WHERE é assim mesmo? */
where estm.estabelecimento_id = '/*empresa_id_vtx*/'
  and substring(eecf.periodo_dtini, 1, 4) = substring('/*per_iniAMD*/', 1, 4)
  and eecf.periodo_dtfin = '/*per_finAMD*/';


Select '1'                                as ID
     , '1'                                as ID_PAI
     , '0010'                             as REG
     , isnull(eecf.HASH_ECF_ANTERIOR, '') as HASH_ECF_ANTERIOR
     , isnull(eecf.OPT_REFIS, 'N')        as OPT_REFIS
     , isnull(eecf.FORMA_TRIB, '')        as FORMA_TRIB
     , isnull(eecf.FORMA_APUR, '')        as FORMA_APUR
     , isnull(eecf.COD_QUALIF_PJ, '01')   as COD_QUALIF_PJ
     , isnull(eecf.FORMA_TRIB_PER, '')    as FORMA_TRIB_PER
     , isnull(eecf.MES_BAL_RED, 'N')      as MES_BAL_RED
     , isnull(eecf.TIP_ESC_PRE, 'N')      as TIP_ESC_PRE
     , isnull(eecf.TIP_ENT, '')           as TIP_ENT
     , isnull(eecf.FORMA_APUR_I, '')      as FORMA_APUR_I
     , isnull(eecf.APUR_CSLL, '')         as APUR_CSLL
     , isnull(eecf.IND_REC_RECEITA, '')   as IND_REC_RECEITA
from estabelecimento_ecf eecf
         inner Join estabelecimentos estm
                    on estm.estabelecimento_id = eecf.estabelecimento_matriz_id
where estm.estabelecimento_id = '/*empresa_id_vtx*/'
  and substring(eecf.periodo_dtini, 1, 4) = substring('/*per_iniAMD*/', 1, 4)
  and eecf.periodo_dtfin = '/*per_finAMD*/';

Select '1'                                                  as ID
     , '1'                                                  as ID_PAI
     , '0020'                                               as REG
    /* --Valor 1 2 ou 3? */
     , isnull(eecf.IND_ALIQ_CSLL, '1')                      as IND_ALIQ_CSLL
     , dbo.Aud_Mask(abs(eecf.PAT_REMAN_CIS), ',', 0, '', 3) as IND_QTE_SCP
    /* --é realmente esses campos da tabela? S ou N?*/
     , isnull(eecf.IND_ADM_FUN_CLUS, 'N')                   as IND_ADM_FUN_CLU
     , isnull(eecf.IND_PART_CONS, 'N')                      as IND_PART_CONS
     , isnull(eecf.IND_OP_EXT, 'N')                         as IND_OP_EXT
     , isnull(eecf.IND_OP_VINC, 'N')                        as IND_OP_VINC
     , isnull(eecf.IND_PJ_ENQUAD, 'N')                      as IND_PJ_ENQUAD
     , isnull(eecf.IND_PART_EXT, 'N')                       as IND_PART_EXT
     , isnull(eecf.IND_ATIV_RURAL, 'N')                     as IND_ATIV_RURAL
     , isnull(eecf.IND_LUC_EXP, 'N')                        as IND_LUC_EXP
     , isnull(eecf.IND_RED_ISEN, 'N')                       as IND_RED_ISEN
     , isnull(eecf.IND_FIN, 'N')                            as IND_FIN
     , isnull(eecf.IND_PART_COLIG, 'N')                     as IND_PART_COLIG
     , isnull(eecf.IND_REC_EXT, 'N')                        as IND_REC_EXT
     , isnull(eecf.IND_ATIV_EXT, 'N')                       as IND_ATIV_EXT
     , isnull(eecf.IND_PGTO_EXT, 'N')                       as IND_PGTO_EXT
     , isnull(eecf.IND_E_COM_TI, 'N')                       as 'IND_E-COM_TI'
     , isnull(eecf.IND_ROY_REC, 'N')                        as IND_ROY_REC
     , isnull(eecf.IND_ROY_PAG, 'N')                        as IND_ROY_PAG
     , isnull(eecf.IND_REND_SERV, 'N')                      as IND_REND_SERV
     , isnull(eecf.IND_PGTO_REM, 'N')                       as IND_PGTO_REM
     , isnull(eecf.IND_INOV_TEC, 'N')                       as IND_INOV_TEC
     , isnull(eecf.IND_CAP_INF, 'N')                        as IND_CAP_INF
     , isnull(eecf.IND_PJ_HAB, 'N')                         as IND_PJ_HAB
     , isnull(eecf.IND_POLO_AM, 'N')                        as IND_POLO_AM
     , isnull(eecf.IND_ZON_EXP, 'N')                        as IND_ZON_EXP
     , isnull(eecf.IND_AREA_COM, 'N')                       as IND_AREA_COM
     , isnull(eecf.IND_PAIS_A_PAIS, 'N')                    as IND_PAIS_A_PAIS
     , isnull(eecf.IND_DEREX, 'N')                          as IND_DEREX
from estabelecimento_ecf eecf
         inner Join estabelecimentos estm
                    on estm.estabelecimento_id = eecf.estabelecimento_matriz_id
where estm.estabelecimento_id = '/*empresa_id_vtx*/'
  and substring(eecf.periodo_dtini, 1, 4) = substring('/*per_iniAMD*/', 1, 4)
  and eecf.periodo_dtfin = '/*per_finAMD*/';


Select '1'                          as ID
     , '1'                          as ID_PAI
     , '0030'                       as REG
     , isnull(estm.REG, 'N')        as REG
     , isnull(estm.cod_nat_jur, '') as COD_NAT
     , isnull(estm.CNAE_FISCAL, '') as CNAE_FISCAL
     , isnull(estm.ENDER, '')       as ENDERECO
     , isnull(estm.NUM, '')         as NUM
     , isnull(estm.COMPL, '')       as COMPL
     , isnull(estm.BAIRRO, '')      as BAIRRO
     , isnull(estm.UF, '')          as UF
     , isnull(estm.COD_MUN, '')     as COD_MUN
     , isnull(estm.CEP, '')         as CEP
     , isnull(estm.FONE, '')        as NUM_TEL
     , isnull(estm.EMAIL, '')       as EMAIL
from estabelecimento_ecf eecf
         inner Join estabelecimentos estm
                    on estm.estabelecimento_id = eecf.estabelecimento_matriz_id
where estm.estabelecimento_id = '/*empresa_id_vtx*/'
  and substring(eecf.periodo_dtini, 1, 4) = substring('/*per_iniAMD*/', 1, 4)
  and eecf.periodo_dtfin = '/*per_finAMD*/';


Select '1'                             as ID
     , '1'                             as ID_PAI
     , '0930'                          as REG
     , isnull(esig.IDENT_NOM, '')      as IDENT_NOM
     , isnull(esig.IDENT_CPF_CNPJ, '') as IDENT_CPF_CNPJ
     , isnull(esig.IDENT_QUALIF, '')   as IDENT_QUALIF
     , isnull(cont.CRC, '')            as IND_CRC
     , isnull(esig.EMAIL, '')          as EMAIL
     , isnull(esig.FONE, '')           as FONE
from estabelecimento_ecf eecf
         inner Join estabelecimentos estm
                    on estm.estabelecimento_id = eecf.estabelecimento_matriz_id
    /* --confirmar se esse é o campo certo para fazer join */
         inner join estabelecimento_signatarios esig
                    on esig.estabelecimento_matriz_id = eecf.estabelecimento_matriz_id
         inner Join contabilistas cont
                    on cont.estabelecimento_matriz_id = eecf.estabelecimento_matriz_id
where estm.estabelecimento_id = '/*empresa_id_vtx*/'
  and substring(eecf.periodo_dtini, 1, 4) = substring('/*per_iniAMD*/', 1, 4)
  and eecf.periodo_dtfin = '/*per_finAMD*/';

Select '1'                                         as ID
     , '1'                                         as ID_PAI
     , 'J050'                                      as REG
    /* --confirmar se esse campo é o inclusao_dt mesmo ou se não precisa */
     , dbo.FormatDateDMA(cta.inclusao_dt)          as DT_ALT
     , isnull(cta.cod_nat_cta, '')                 as COD_NAT
     , isnull(cta.IND_CTA, '')                     as IND_CTA
     , dbo.Aud_Mask(abs(cta.NIVEL), ',', 0, '', 2) as NÍVEL
     , isnull(cta.COD_CTA, '')                     as COD_CTA
     , isnull(cta.COD_CTA_SUP, '')                 as COD_CTA_SUP
     , isnull(cta.NOME_CTA, '')                    as CTA
from estabelecimento_ecf eecf
         inner Join estabelecimentos estm
                    on estm.estabelecimento_id = eecf.estabelecimento_matriz_id
         inner join contas cta
                    on cta.estabelecimento_matriz_id = eecf.estabelecimento_matriz_id
where estm.estabelecimento_id = '/*empresa_id_vtx*/'
  and substring(eecf.periodo_dtini, 1, 4) = substring('/*per_iniAMD*/', 1, 4)
  and eecf.periodo_dtfin = '/*per_finAMD*/';


Select '1'                            as ID
     , '1'                            as ID_PAI
     , 'J051'                         as REG
     , isnull(ctaref.COD_CCUS, '')    as COD_CCUS
     , isnull(ctaref.COD_CTA_REF, '') as COD_CTA_REF
from estabelecimento_ecf eecf
         inner Join estabelecimentos estm
                    on estm.estabelecimento_id = eecf.estabelecimento_matriz_id
         inner join conta_contasref ctaref
                    on ctaref.estabelecimento_matriz_id = eecf.estabelecimento_matriz_id
         inner Join contabilistas cont
                    on cont.estabelecimento_matriz_id = eecf.estabelecimento_matriz_id
where estm.estabelecimento_id = '/*empresa_id_vtx*/'
  and substring(eecf.periodo_dtini, 1, 4) = substring('/*per_iniAMD*/', 1, 4)
  and eecf.periodo_dtfin = '/*per_finAMD*/';