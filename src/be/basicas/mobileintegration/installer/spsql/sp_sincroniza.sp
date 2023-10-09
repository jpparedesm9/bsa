/*************************************************************************/
/*   Archivo:            sp_sincroniza.sp                                */
/*   Stored procedure:   sp_sincroniza                                   */
/*   Base de datos:      cob_sincroniza                                  */
/*   Producto:           App mobil Santander                             */
/*   Disenado por:       Nelson Trujillo                                 */
/*   Fecha de escritura: 28/07/2017                                      */
/*************************************************************************/        
/*                                  PROPOSITO                            */
/* Este programa da mantenimiento a la tabla si_sincroniza_det           */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     Q            Consulta una entidad a sincronizar                   */
/*     S            Consulta entidades a sincronizar paginado            */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 28-07-2017 Nelson Trujillo             Emisión inicial 1              */
/* 28-11-2017 Paúl Ortiz Vera             Administracion - Sincronizacion*/
/* 28-11-2017 ACHP                        Administracion - Sincronizacion*/
/* 16/08/2021 Sonia Rojas                 161141                         */
/*************************************************************************/

use cob_sincroniza
go

if exists (select 1 from sysobjects where name = 'sp_sincroniza')
   drop proc sp_sincroniza
go

create procedure sp_sincroniza(
   @s_ssn            int         = null,
   @s_user           login       = null,
   @s_term           varchar(32) = null,
   @s_date           datetime    = null,
   @s_sesn           int         = null,
   @s_culture        varchar(10) = null,
   @s_srv            varchar(30) = null,
   @s_lsrv           varchar(30) = null,
   @s_ofi            smallint    = null,
   @s_rol            smallint    = NULL,
   @s_org_err        char(1)     = NULL,
   @s_error          int         = NULL,
   @s_sev            tinyint     = NULL,
   @s_msg            descripcion = NULL,
   @s_org            char(1)     = NULL,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(10) = null,
   @t_from           varchar(32) = null,
   @t_trn            smallint    = null,   
   @t_show_version   bit         = 0,   --* Mostrar la version del programa
   @i_operacion      char(1),             -- Opcion con la que se ejecuta el programa
   @i_tipo           char(1)     = null,  -- Tipo de busqueda
   @i_modo           int         = null,  -- Modo de consulta
   @i_id             VARCHAR(50) = null,  
   @i_id_sync        int         = 0,
   @i_page           int         = 1, --pagina a recuperar
   @i_page_size      int         = 5,--tamanio de pagina
   @i_usuario        varchar(20) = null,
   @i_estado         char(1)     = null,
   @i_fecha_ing      varchar(10) = null,
   @i_fecha_sin      varchar(10) = null,
   @i_codigo         int         = null
)
as
begin
declare 
@w_today   datetime,
@w_sp_name       varchar(32),
@w_return        int,
@w_error_number  int,
@w_estado        varchar(10),
@w_fecha_sin     datetime,
@w_siguiente     int,
@w_primero       int,
@w_primer_reg    int,
@w_ultimo_reg    int


set @w_sp_name = 'sp_sincroniza'

--* VERSIONAMIENTO DEL PROGRAMA
  if @t_show_version = 1
  begin
    print 'Stored Procedure = sp_sincroniza Version = 1.0.0'
    return 0
  end

if @i_operacion='Q'
begin
    
    SELECT  'sa_dato_xml'       = sid_xml, 
            'sa_id'             = sid_secuencial, 
            'sa_observacion'    = sid_observacion, 
            'sa_accion'         = sid_accion
      from si_sincroniza_det
      where sid_id = @i_id      
      
      return 0
  
end -- end @i_operacion Q


if @i_operacion='S'
BEGIN   
	
   select top 1 @w_primero = sid_id 
   from cob_sincroniza..si_sincroniza_det
   where sid_secuencial = @i_id_sync
   order by sid_id asc
      
   select @w_primer_reg = @w_primero + ((@i_page - 1) * 10)
   select @w_ultimo_reg = @w_primer_reg + 10
   
   print 'Página: '+ convert(varchar, @i_page )+', Primer Registro: '+ convert(varchar, @w_primer_reg )+ ', Ultimo Registro: '+ convert(varchar, @w_ultimo_reg )
	
   select  
   'sa_id'                = sid_id ,    
   'sa_observacion'       = sid_observacion, 
   'sa_accion'            = sid_accion            
   from cob_sincroniza..si_sincroniza tc
   join cob_sincroniza..si_sincroniza_det sa
   on tc.si_secuencial    = sa.sid_secuencial
   where tc.si_secuencial = @i_id_sync
   and tc.si_estado       = 'D'
   and sid_id >= @w_primer_reg 
   and sid_id < @w_ultimo_reg
   order by si_secuencial asc
   OFFSET 0 ROWS 
   FETCH FIRST @i_page_size ROWS ONLY   
   
   
   update cob_sincroniza..si_sincroniza_det
   set sid_descargado   = 1
   where sid_secuencial = @i_id_sync
   and sid_id           >= @w_primer_reg 
   and sid_id           < @w_ultimo_reg
   and sid_descargado   = 0


   return 0

END -- end @i_operacion S


if @i_operacion='G'
BEGIN
    
    /* Se re-asigna @i_usuario para consulta */
    select @i_usuario = fu_login from  cobis..cc_oficial,cobis..cl_funcionario
    where oc_funcionario = fu_funcionario and oc_oficial = @i_usuario
    
    SELECT  'secuencial'      = si_secuencial ,
            'entidad'         = si_cod_entidad,
            'entidadDesc'     = si_des_entidad,
            'usuario'         = (select substring(fu_nombre,1,64) from  cobis..cc_oficial,cobis..cl_funcionario
                                       where oc_funcionario = fu_funcionario and fu_login = si_usuario),
            'estado'          = si_estado,
            'fechaIngreso'    = convert(varchar(10), si_fecha_ing, 103),
            'fechaSincron'    = convert(varchar(10), si_fecha_sin, 103)
    FROM cob_sincroniza..si_sincroniza
    WHERE (si_usuario = @i_usuario OR @i_usuario is null)
    and (si_estado = @i_estado OR @i_estado is null)
    and (convert(varchar(10), si_fecha_ing, 103) = @i_fecha_ing OR @i_fecha_ing is null)
    and (convert(varchar(10), si_fecha_sin, 103) = @i_fecha_sin OR @i_fecha_sin is null)
    
    return 0

END -- end @i_operacion G


if @i_operacion = 'U'
begin
    
    select
        @w_estado            = si_estado,
        @w_fecha_sin         = si_fecha_sin
    from cob_sincroniza..si_sincroniza
    where si_secuencial = @i_codigo
    
    if @@rowcount = 0
    begin
        select @w_error_number =  2109107 --No existe el registro que desea actualizar
        goto ERROR
    end
    
    begin tran
      
    if @i_estado is not null
        select @w_estado = @i_estado
    
    if (@i_estado = 'P')
   select @w_fecha_sin = null
    
         /* Se actualiza el estado */
    update cob_sincroniza..si_sincroniza
    set si_estado              = @w_estado,
        si_fecha_sin           = @w_fecha_sin
    where si_secuencial = @i_codigo
      
        if @@error != 0
        begin
            select @w_error_number = 2109108 --ERROR AL ACTUALIZAR MOVIL DEL OFICIAL!
            goto ERROR
        end
      
      commit tran
    return 0
end


ERROR:
    EXEC cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_error_number

    RETURN 1
end
GO
