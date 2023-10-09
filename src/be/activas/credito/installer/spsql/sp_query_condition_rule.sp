/************************************************************************/
/*      Archivo:                sp_query_condition_rule.sp              */
/*      Stored procedure:       sp_query_condition_rule                 */
/*      Base de datos:          cob_credito                             */
/*      Producto:               CREDITO                                 */
/*      Disenado por:           Nelson Trujillo                         */
/*      Fecha de escritura:     09-MAY-2018                             */
/* **********************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/* **********************************************************************/
/*                             PROPOSITO                                */
/*    Consulta las condiciones de una regla                             */
/* **********************************************************************/
/*                           MODIFICACIONES                             */
/* Fecha       Autor             Razon                                  */
/* 09/05/2018  ntrujillo         REQ 93605 CIFIN                        */
/* 														                */
/* **********************************************************************/
use cob_credito
go

if exists (select *
           from   sysobjects
           where  name = 'sp_query_condition_rule')
           drop proc sp_query_condition_rule
go

create proc sp_query_condition_rule(
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_user         login = null,
  @s_term         descripcion = null,
  @s_corr         char(1) = null,
  @s_ssn_corr     int = null,
  @s_ofi          smallint = null,
  @s_sesn         int = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @t_rty          char(1) = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_online       varchar(10) = 'N',
  @i_ente         int = null,
  @i_acronym      varchar(30),	
  @i_operation    varchar(1),
  @i_formato      tinyint = 101)
as
begin
  declare
    @w_rv_id INT,
	@w_sp_name varchar(50),
	@w_error_number INT
	
  select
    @w_sp_name = 'sp_query_condition_rule'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '1.0.0.0'
    return 0
  end

  if @i_operation = 'Q'     
  begin
  
  select @w_rv_id = rv_id from cob_pac..bpl_rule rl
	inner join cob_pac..bpl_rule_version rv
	on rl.rl_id = rv.rl_id
	and rl.rl_acronym = @i_acronym
	and rv_status = 'PRO'
	
	if @@error <> 0
	begin
         set @w_error_number = 2805038
         goto ERROR
     end

	select 	'operator' =cr_operator, 
	'min_value'=(case when cr_min_value is null or cr_min_value = '' then convert(integer,cr_max_value) else convert(integer,cr_min_value) end) ,
	'max_value'=(case when cr_max_value is null or cr_max_value = '' then convert(integer,cr_min_value) else convert(integer,cr_max_value) end) ,
	'rate'=(select cr_max_value from cob_pac..bpl_condition_rule icr where icr.rv_id = ecr.rv_id and icr.cr_parent = ecr.cr_id )
	from cob_pac..bpl_condition_rule ecr where rv_id =  @w_rv_id
	and cr_is_last_son = 0
	order by min_value

	if @@error <> 0
	begin
         set @w_error_number = 2805038
         goto ERROR
     end
   
  end

  RETURN 0

	ERROR:
		EXEC cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = @w_error_number
		RETURN 1
end
go

