/****************************************************************************/ 
/*      Archivo:                reofican.sp                                 */ 
/*      Stored procedure:       sp_oficina_tipo_canje                       */ 
/*      Base de datos:          cob_remesas                                 */ 
/*      Producto:               Cuentas Corrientes                          */ 
/*      Disenado por:           Oscar Velez                                 */ 
/*      Fecha de escritura:     04-Febrero-2005                             */ 
/****************************************************************************/ 
/*                              IMPORTANTE                                  */ 
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/ 
/*                              PROPOSITO                                   */ 
/*         Programa que realiza las diferentes operaciones                  */
/*         de la pantalla  Parametrizacion por Tipo de canje                */ 
/****************************************************************************/ 
/*                              MODIFICACIONES                              */ 
/*      FECHA           AUTOR              RAZON                            */ 
/*     04/Feb/2005     O. Velez         Emision Inicial                     */ 
/*     22/Nov/2005     C. Leon      Incluir competencia a oficinas          */
/*     26/Jun/2016     J. TAgle     Recursos a Salida - Migración CEN       */
/****************************************************************************/ 
                                   
                                   
use cob_remesas                                                            
go                                                                         
                                                                           
if exists (select * from sysobjects where name = 'sp_oficina_tipo_canje')
        drop proc sp_oficina_tipo_canje                                
go                                                                         
                                                                       
create proc sp_oficina_tipo_canje( 
        @s_ssn      int,       
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user     varchar(30),
    @s_sesn         int=null,  
    @s_term         varchar(10),
    @s_date     datetime,  
    @s_ofi      smallint,  
    @s_rol      smallint,  
    @s_org      char(1),   
    @t_debug    char(1) = 'N',
    @t_file     varchar(14)=null,
    @t_from         varchar(32)=null,
    @t_rty      char(1) = 'N',
    @t_trn      smallint,                                       
    @i_oficina  smallint = null,                                    
    @i_tipo_canje   char(1) = null,                                    
    @i_modo     tinyint = null,                                            
        @i_operacion    char(1),                                   
        @i_descripcion  varchar(30) = null,
    @i_competencia  char(1) = null          
)                                  
                                   
                                   
as declare      @w_sp_name varchar(64),
        @w_return  int,
        @w_ssn     int
                              
                                   
/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_oficina_tipo_canje'


/* Encuentra el SSN inicial */ 
select @w_ssn = se_numero      
  from cobis..ba_secuencial    
  
 if @@rowcount <> 1                
   begin                           
     /* Error en lectura de SSN */ 
     exec cobis..sp_cerror           
          @i_num       = 201163      
     return 201163                   
   end                               
                                   
                                   
/*  Valida codigo de Transaccion  */
if @t_trn <> 672                   
begin                              
   /*  Error en codigo de transaccion  */
   exec cobis..sp_cerror           
    @t_debug = @t_debug,           
    @t_file  = @t_file,            
    @t_from  = @w_sp_name,         
    @i_num   = 201048              
    return     201048              
end                                

if @i_operacion = 'S'              
begin                              
  set rowcount 20                  
  if @i_modo = 0                   
  begin                            
    select                         
    '508991' = oc_oficina,                           -- 'Cod Oficina'                        
    '508992' = substring(of_nombre,1,30),            -- 'Oficina'            
    '508993' = oc_tipo_canje,                        -- 'Tipo de Canje '     
    '508994' = substring(oc_descr_tipo,1,30),        -- 'Descripcion de Tipo'
    '508995' =  convert(char(10),oc_fecha_mod,101),  -- 'Fecha Mod'          
    '508996' = oc_competencia                        -- 'Competencia'        
    from re_oficina_canje, cobis..cl_oficina
    where oc_oficina = of_oficina        
    order by    oc_oficina         
  end                              
                                   
  else                             
  begin                            
    select                         
    '508991' = oc_oficina,                           -- 'Cod Oficina'                       
    '508992' = substring(of_nombre,1,30),            -- 'Oficina'                     
    '508993' = oc_tipo_canje,                        -- 'Tipo de Canje '           
    '508994' = substring(oc_descr_tipo,1,30),        -- 'Descripcion de Tipo'
    '508995' = convert(char(10),oc_fecha_mod,101),   -- 'Fecha Mod'                 
    '508996' = oc_competencia                        -- 'Competencia'        
    from re_oficina_canje, cobis..cl_oficina
    where oc_oficina > @i_oficina  
    and oc_oficina = of_oficina    
     order by   oc_oficina        
  end                              
                                   
                                   
  set rowcount 0                   
end                                
                                   
                                   
if not exists(select 1 from cobis..cl_oficina where of_oficina=@i_oficina)
begin                                                                    
   exec cobis..sp_cerror                                                 
   @t_debug = @t_debug,                                                  
   @t_file  = @t_file,                                                   
   @t_from  = @w_sp_name,                                                
   @i_num   = 101016                                                     
   return     101016                                                     
end                                                                      
                                   
                                   
                                   
if @i_operacion = 'I'              
begin                              
                                   
  if exists(select 1 from re_oficina_canje where oc_oficina=@i_oficina)
  begin                            
    exec cobis..sp_cerror          
    @t_debug = @t_debug,           
    @t_file  = @t_file,            
    @t_from  = @w_sp_name,         
    @i_num   = 352004              
    return     352004                      
  end                              
  else                             
  begin                            
    Begin tran                     
     insert into re_oficina_canje  
     values(@i_oficina, @i_tipo_canje,@i_descripcion,@s_date, @i_competencia)
                                   
     if @@error <> 0               
     begin                         
       exec cobis..sp_cerror       
       @t_debug = @t_debug,        
       @t_file  = @t_file,         
       @t_from  = @w_sp_name,      
       @i_num   = 352000           
       return     352000           
     end                           
     
     insert into cob_cuentas..cc_tran_servicio               
           (ts_secuencial, ts_tipo_transaccion, ts_tsfecha,   
           ts_usuario, ts_terminal, ts_oficina,               
           ts_prod_banc,ts_tipo,ts_ofi_aut,ts_tipo_imp,ts_agente, ts_categoria)                                  
     values (@w_ssn, 672, getdate(),@s_user,@s_term,@s_ofi,10,'I'
             ,@i_oficina,@i_tipo_canje,@i_descripcion, @i_competencia)
     
        if @@error != 0
    begin
         /* Error en creacion de registro en transaccion de servicio */
         exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 353515
         return 353515
        end  
                                  
     update cobis..ba_secuencial 
     set se_numero = @w_ssn + 1
     
     if @@rowcount <> 1
     begin
       /* Error en actualizacion de SSN */
       exec cobis..sp_cerror
            @i_num       = 205031
       return 205031
     end         
     
    Commit tran                    
                                   
  end                              
                                   
end                                
                                   
                                   
if @i_operacion = 'U'              
begin                              
                                   
  if exists(select 1 from re_oficina_canje where oc_oficina=@i_oficina)
  begin                            
  Begin tran                       
  update re_oficina_canje set      
   oc_descr_tipo = @i_descripcion, 
   oc_tipo_canje = @i_tipo_canje,   
   oc_fecha_mod  = @s_date,         
   oc_competencia= @i_competencia
  where oc_oficina = @i_oficina    
                                   
     if @@error <> 0               
     begin                         
      exec cobis..sp_cerror        
      @t_debug = @t_debug,         
      @t_file  = @t_file,          
      @t_from  = @w_sp_name,       
      @i_num   = 352001            
      return     352001                      
     end 
     
   insert into cob_cuentas..cc_tran_servicio               
           (ts_secuencial, ts_tipo_transaccion, ts_tsfecha,   
           ts_usuario, ts_terminal, ts_oficina,              
           ts_prod_banc,ts_tipo,ts_ofi_aut,ts_tipo_imp,ts_agente, ts_categoria)                                  
     values (@w_ssn, 672, getdate(),@s_user,@s_term,@s_ofi,10,'U'
             ,@i_oficina,@i_tipo_canje,@i_descripcion, @i_competencia)

        if @@error != 0
    begin
         /* Error en creacion de registro en transaccion de servicio */
         exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 353515
         return 353515
        end  
                                      
     update cobis..ba_secuencial 
     set se_numero = @w_ssn + 1  

     if @@rowcount <> 1
     begin
       /* Error en actualizacion de SSN */
       exec cobis..sp_cerror
            @i_num       = 205031
       return 205031
     end      
     
                               
  Commit tran                      
  end                              
                                   
  else   /* No existe tipo de canje para esa oficina*/
  begin                            
   exec cobis..sp_cerror           
   @t_debug = @t_debug,            
   @t_file  = @t_file,             
   @t_from  = @w_sp_name,          
   @i_num   = 352003               
   return     352003               
  end                              
                                   
end                                
                                   
                                   
if @i_operacion = 'D'              
begin                              
  if exists(select 1 from re_oficina_canje where oc_oficina=@i_oficina)
  begin                            
    Begin tran                     
     delete cob_remesas..re_oficina_canje  
     where oc_oficina = @i_oficina 
        if @@error <> 0            
        begin                      
         exec cobis..sp_cerror     
         @t_debug = @t_debug,      
         @t_file  = @t_file,       
         @t_from  = @w_sp_name,    
         @i_num   = 352002            
         return     352002           
        end          
      
      insert into cob_cuentas..cc_tran_servicio               
           (ts_secuencial, ts_tipo_transaccion, ts_tsfecha,   
           ts_usuario, ts_terminal, ts_oficina,              
           ts_prod_banc,ts_tipo,ts_ofi_aut)                                  
     values (@w_ssn, 672, getdate(),@s_user,@s_term,@s_ofi,10,'D'
             ,@i_oficina)
                                      
     update cobis..ba_secuencial 
     set se_numero = @w_ssn + 1
                      
    Commit tran                    
  end                              
  else                             
  begin                            
   exec cobis..sp_cerror           
   @t_debug = @t_debug,            
   @t_file  = @t_file,             
   @t_from  = @w_sp_name,          
   @i_num   = 352003               
   return     352003               
  end                              
                                   
end                                

return 0
go
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   