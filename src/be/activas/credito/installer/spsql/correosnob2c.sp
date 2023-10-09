/************************************************************************/
/*      Archivo:                correosnob2c.sp                         */
/*      Stored procedure:       sp_correos_no_b2c			               */
/*      Base de datos:          cob_credito                             */
/*      Producto:               Credito                                 */
/*      Disenado por:           ALD                                     */
/*      Fecha de escritura:     Nov/2019                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Enviar un código de registro al renovar un credito grupal para  */
/*      los clientes que no esten registrados en la B2C.                */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA         AUTOR                 RAZON                         */
/*  25/Nov/2019      ALD              Emision Inicial                   */
/*  06/Mar/2020    P. Ortiz           No enviar si ya existe codigo     */
/************************************************************************/


use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_correos_no_b2c')
	drop proc sp_correos_no_b2c
go


create proc sp_correos_no_b2c(
   @s_ssn          int         = null,
   @s_ofi          smallint    = null,
   @s_user         login       = null,
   @s_date         datetime    = null,
   @s_srv          varchar(30) = null,
   @s_term	       descripcion = null,
   @s_rol          smallint    = null,
   @s_lsrv	       varchar(30) = null,
   @s_sesn	       int 	       = null,
   @s_org          char(1)     = null,
   @s_org_err      int 	       = null,
   @s_error        int 	       = null,
   @s_sev          tinyint     = null,
   @s_msg          descripcion = null,
   @t_rty          char(1)     = null,
   @t_trn          int         = null,
   @t_debug        char(1)     = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(30) = null,
   --variables
   @i_id_inst_proc int,    --codigo de instancia del proceso
   @i_id_inst_act  int,    
   @i_id_empresa   int, 
   @o_id_resultado smallint  out
)
as
declare @w_sp_name         varchar(32),
        @w_tramite         int,
        @w_return          int,
        ---var variables   
        @w_asig_actividad  int,
        @w_valor_ant       varchar(255),
        @w_valor_nuevo     varchar(255),
        @w_ente            int,
        @w_observaciones   varchar(1000),
        @w_fecha           datetime,
        @w_nombre          varchar(64),
        @w_p_apellido      varchar(64),
        @w_s_apellido      varchar(64),
        @w_correo          varchar(64),
        @w_error           int,
        @w_error_2         int,
        @w_ttramite        varchar(255),
        @w_banco           cuenta,
        @w_registro_id 	   varchar(100),
        @w_msg             varchar(255),
        @w_num_clientes    int

select @w_sp_name='sp_correos_no_b2c'


create table #correos_prueba(cp_ente int)

select @w_ente       = convert(int,io_campo_1),
      @w_tramite    = convert(int,io_campo_3),
      @w_ttramite   = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_fecha = fp_fecha from cobis..ba_fecha_proceso

if @w_ttramite = 'GRUPAL'
begin
   insert into #correos_prueba(cp_ente)
   select distinct(cg_ente) 
   from   cobis..cl_cliente_grupo
   where  cg_grupo = @w_ente	
   and cg_estado='V' 
   and cg_ente not in (select lo_ente from cob_bvirtual..bv_login)
end
else
begin
   insert into #correos_prueba(cp_ente)
   select @w_ente
end

select @w_num_clientes=count(*) from #correos_prueba

while(@w_num_clientes>0)
begin	
   select @w_ente = min(cp_ente) from #correos_prueba
   
   if not exists (select 1  from  cob_credito..cr_b2c_registro 
           where rb_cliente = @w_ente and rb_fecha_vigencia >= @w_fecha)
   begin
      
      exec @w_error = cob_credito..sp_lcr_ingresar_registro 
      @i_id_inst_proc	= @i_id_inst_proc, 
      @o_registro_id	= @w_registro_id output, 
      @o_msg        	= @w_msg output     
      print 'Pasa digito'
       
      select 	@w_nombre   = en_nombre,
         @w_p_apellido	= p_p_apellido,
         @w_s_apellido  = p_s_apellido,
         @w_correo      = (select top 1 di_descripcion from cobis..cl_direccion 
                              where di_ente = en_ente and di_tipo = 'CE')
      from cobis..cl_ente
      where en_ente = @w_ente
      
      print 'Imprime @w_error' + convert(varchar,@w_error)
      

      if(@w_error = 0 AND @w_ttramite <> 'GRUPAL')
      begin
         print 'Antes de insertar cr_ns_creacion_lcr'
         insert into cob_credito..cr_ns_creacion_lcr
              (nc_tramite, nc_fecha_reg, nc_cliente, nc_nombre, nc_apellido_paterno, nc_apellido_materno, nc_correo, nc_digito, nc_estado)
         values (@w_tramite, @w_fecha, @w_ente, @w_nombre, @w_p_apellido, @w_s_apellido, @w_correo, @w_registro_id, 'P')

         select @o_id_resultado = 1
      end
   end
   
   delete from #correos_prueba where  cp_ente= @w_ente
	select @w_num_clientes=count(*) from #correos_prueba
end

select @o_id_resultado = 1
return 0
go


