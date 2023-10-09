/****************************************************************************/
/*     Archivo:          pe_caradi.sp                                       */
/*     Stored procedure: sp_caradicionales                                  */
/*     Base de datos:    cob_remesas                                        */
/*     Producto:         Personalizacion                                    */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 18-Jul-2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de 'COBISCorp'.                                                         */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa inserta/elimina/actualiza/consulta de caracteristicas  */
/*     adicionales de los productos finales.                                */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*    FECHA          AUTOR          RAZON                                   */
/*    18/Jul/2016   Juan Tagle      Emision Inicial                         */
/****************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_caradicionales')
  drop proc sp_caradicionales
go

create proc sp_caradicionales
(
  @s_ssn          int,
  @s_srv          varchar(30)=null,
  @s_lsrv         varchar(30)=null,
  @s_user         varchar(30)=null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char (1),
  @s_ofi          smallint,
  @s_rol          smallint =1,
  @s_org_err      char(1)=null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1)='N',
  @t_file         varchar(14)=null,
  @t_from         varchar(32)=null,
  @t_rty          char(1)='N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char(2),
  @i_modo         tinyint = null,
  @i_pro_final    smallint = null,
  @i_provisiona      char(1) = null,
  @i_depende         smallint = null,
  @i_cod_rango_edad  tinyint=null
)
as
  declare
    @w_sp_name    varchar(32),
    @w_return     int,
    @w_pro_final  smallint,
    @w_provisiona      char(1) = null,
    @w_depende         catalogo=null,
    @w_cod_rango_edad  tinyint=null

  select
    @w_sp_name = 'sp_caradicionales'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end


/* *BUSQUEDA * */
if @i_operacion = 'S'
begin
    if @t_trn <> 425
    begin
        /*Error en codigo de transaccion*/
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351516  
            return 351516
    end

    set rowcount 15
    
    select
    @w_provisiona     = pf_provisiona,
    @w_depende        = pf_depende,
    @w_cod_rango_edad = pf_cod_rango_edad
    from   pe_pro_final
    where  pf_pro_final    = @i_pro_final

    set rowcount 0
    
    select
    @w_provisiona,
    @w_depende,
    @w_cod_rango_edad
    
    return 0
end


/* *ACTUALIZACION* */
if @i_operacion = 'U'
begin
    if @t_trn <> 426
    begin
        /* ERROR - DEPENDENCIA CIRCULAR EN PRODUCTO FINAL */
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357561
            return 357561
    end

    -----------------------------------------------------
    -- VERIFICACION DE DEPENDENCIA CIRCULAR
    if not(@i_depende is null)
    begin
        
        declare @w_flag integer,
                @w_dep_prod smallint,
                @w_dep_dep smallint

        select @w_flag = 0,
                @w_dep_prod = @i_pro_final,
                @w_dep_dep = @i_depende

        -- print 'Producto: ' + convert(varchar(10),@w_dep_prod) + ' Dep NUEVA: ' + convert(varchar(10),@w_dep_dep)
                
        WHILE (@w_flag = 0)
        BEGIN  
            if @w_dep_prod = @w_dep_dep
            begin
                /*'ERROR - DEPENDENCIA CIRCULAR EN PRODUCTO FINAL'*/
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 357561
                    return 357561
                break
            end
            
            select
            @w_dep_prod  = pf_pro_final,
            @w_dep_dep   = pf_depende
            from   pe_pro_final
            where  pf_pro_final = @w_dep_dep
            
            -- print 'Producto: ' + convert(varchar(10),@w_dep_prod) + ' Dep NUEVA: ' + convert(varchar(10),@w_dep_dep)

            if (@i_pro_final = @w_dep_dep)
            begin
                /*'ERROR - DEPENDENCIA CIRCULAR EN PRODUCTO FINAL'*/
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 357561
                    return 357561
                break           
            end
            
            if (@w_dep_dep IS NULL)
                select @w_flag = 1

        END  
        
    end -- not(@i_depende is null)
    -----------------------------------------------------
        
    if @w_flag = 1 or (@i_depende is null)
    begin
        begin tran
        
        /*Actualizar productos finales*/
        update pe_pro_final
        set    
        pf_provisiona      = @i_provisiona,
        pf_depende         = @i_depende,
        pf_cod_rango_edad  = @i_cod_rango_edad
        where 
        pf_pro_final       = @i_pro_final
        
        if @@rowcount <> 1
        begin
        rollback tran
            /*Error en actualizacion de producto final*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 355506
            return 355506
        end
        
         insert into cob_remesas..pe_tran_servicio
                (ts_secuencial,     ts_tipo_transaccion,   ts_oficina, 
                 ts_usuario,        ts_terminal,           ts_fecha_cambio,   
                 ts_codigo,         ts_pro_final,             ts_tipo,  
                 ts_operacion,      ts_categoria,           ts_hora)
        values 
                (@s_ssn,            @t_trn,                @s_ofi,
                 @s_user,           @s_term,               @s_date,
                 @i_cod_rango_edad, @i_pro_final,          @i_provisiona,  
                 @i_operacion,      @i_depende,             getdate())
        if @@error != 0 
        begin
        rollback tran
             /*Error en actualizacion de producto final*/
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 355506
                return 355506
        end        
       
       commit tran
                     
    end
        
    return 0
end


go 
