/************************************************************************/
/*  Archivo:                sp_valida_bandera_bio.sp                     */
/*  Stored procedure:       sp_valida_bandera_bio                        */
/*  Base de Datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           Pedro Romero                                */
/*  Fecha de Documentacion: 05/Feb/2020                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Retorna un SI o NO dependiendo del parametro VBIO y la paramtria de  */
/* oficinas que validan biocheck									    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   05/02/2020 P. Romero       Emision Inicial                         */
/*   18/10/2021 D. Cumbal       Validacion Monto Grupal                 */
/* **********************************************************************/
use cobis
go
if object_id('dbo.sp_valida_bandera_bio') is not null
	drop procedure dbo.sp_valida_bandera_bio
go

create proc sp_valida_bandera_bio(
	@s_ssn          int          = null,
	@s_ofi          smallint     = null,
	@s_user         login        = null,
    @s_date         datetime     = null,
	@s_srv		    varchar(30)  = null,
	@s_term	        descripcion  = null,
	@s_rol		    smallint     = null,
	@s_lsrv	        varchar(30)  = null,
	@s_sesn	        int 	     = null,
	@s_org		    char(1)      = NULL,
	@s_org_err      int 	     = null,
    @s_error        int 	     = null,
    @s_sev          tinyint      = null,
    @s_msg          descripcion  = null,
    @t_rty          char(1)      = null,
    @t_trn          int          = null,
    @t_debug        char(1)      = 'N',
    @t_file         varchar(14)  = null,
    @t_from         varchar(30)  = null,
	@i_id_inst_proc int,    
	@i_id_inst_act  int,
	@i_id_asig_act  int,
	@i_id_empresa   int,
	@i_id_variable  smallint
	)
as
declare @w_sp_name       	varchar(32),
		@w_val_param		char(1),
		@w_valor_ant      	varchar(255),
        @w_valor_nuevo    	varchar(255),
		@w_tramite			int,
		@w_oficina          smallint,
		@w_param_ofis		int,
		@w_val_param_monto  money,
		@w_cliente          int,
		@w_monto_cliente    money,
		@w_tipo_solicitud   varchar(255)

select @w_val_param = pa_char from cl_parametro where pa_nemonico='VBIO' and pa_producto='CLI'
select @w_val_param_monto = isnull(pa_money,0) from cl_parametro where pa_nemonico = 'VAMOBI' and pa_producto='CLI'

--SI NO HAY PARAMETRIA DE OFICINAS PARA BIOCHECK SE CONSIDERA SOLO EL PARAMETRO VBIO
select @w_param_ofis = count(*) from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_ofi_biocheck')

select 
@w_tramite = io_campo_3 ,
@w_tipo_solicitud = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_oficina = tr_oficina
from   cob_credito..cr_tramite
where  tr_tramite = @w_tramite

if (exists (select * from cl_catalogo c,cl_tabla t where t.codigo = c.tabla  and t.tabla = 'cl_ofi_biocheck' and c.codigo = convert(varchar(5),@w_oficina) and c.estado='V') and @w_val_param ='S')
	OR (@w_val_param ='S' AND @w_param_ofis = 0)
	select @w_valor_nuevo = 'SI'
else
	select @w_valor_nuevo = 'NO'

if @w_valor_nuevo = 'SI'
begin
   select @w_cliente = 0
   if @w_tipo_solicitud = 'GRUPAL'
   begin
      print 'ENTRA A VALIDAR MONTOS BIOMETRICO '
      select @w_valor_nuevo = 'NO'
      while 1 = 1
      begin 
         select top 1
	     @w_cliente       = tg_cliente,
	     @w_monto_cliente = tg_monto
         from cob_credito..cr_tramite_grupal
         where tg_tramite = @w_tramite
         and   tg_cliente > @w_cliente
	     and   tg_monto   > 0
	     and   tg_participa_ciclo = 'S'
         order by tg_cliente
	     
	     if @@rowcount = 0 break
          
         if @w_monto_cliente >= @w_val_param_monto
         begin
	        print 'ENTRA A VALIDAR BIOMETRICO CLIENTE: '+ convert(varchar, @w_cliente) + ' Monto: ' + convert(varchar,@w_monto_cliente) 
            select @w_valor_nuevo = 'SI'
		    break
         end 
         
      end     
   end    
end 	

print 'VALIDA BIOMETRICO: '+@w_valor_nuevo
	
--insercion en estrucuturas de variables

if @i_id_asig_act is null
  select @i_id_asig_act = 0

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())
			
	if @@error > 0
	begin
            --registro ya existe
			
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end 

END

go
