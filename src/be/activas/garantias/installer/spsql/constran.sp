/************************************************************************/
/*	Archivo: 	        constran.sp                             */
/*	Stored procedure:       sp_consulta_trans                       */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Anita Oleas                             */
/*	Fecha de escritura:     May/14/98  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Consulta y Busqueda de Transacciones Monetarias                 */
/************************************************************************/
/*				MODIFICACIONES				*/
/*      FECHA       AUTOR		 RAZON		                */
/*  	May/15/98   A.O                  Emision Inicial	        */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_consulta_trans')
    drop proc sp_consulta_trans
go
create proc sp_consulta_trans (
   @s_date               datetime = null,
   @s_user               login    = null,
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_descripcion        descripcion  = null,
   @i_fecha1             datetime  =  null,
   @i_fecha2             datetime  =  null,
   @i_formato_fecha      int       =  null, --PGA 16/06/2000
   @i_usuario 		 login     =  null,
   @i_param1      	 varchar(64)   = null,
   @i_secuencial         int      = null,
   @i_codigo_externo     varchar(64) = null,
   @i_tran               varchar(10) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_fecha_tran         datetime,
   @w_valor              money,
   @w_descripcion        descripcion,
   @w_error              int,
   @w_usuario 		 login,
   @w_valor_custodia 	 money,
   @w_valor_actual   	 float, 	--money NVR-mar-5-99,
   @w_codigo_externo     varchar(64),
   @w_clave              varchar(64),
   @w_valor_cobertura    money,      
   @w_valor_inicial      float, 	--money NVR-mar-5-99,
   @w_nombre_usr         varchar(50),
   @w_garante            varchar(50),
   @w_deudor             varchar(50),
   @w_estado             char(3),
   @w_secuencial         int,
   @w_tran               varchar(10),
   @w_oficina_orig       smallint,
   @w_oficina_dest       smallint

--select @w_today = convert(varchar(10),getdate(),101)
select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_consulta_trans'

/***********************************************************/

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
if @i_codigo_externo is not null
   begin
   select 
   @w_secuencial     = tr_secuencial,
   @w_codigo_externo = tr_codigo_externo,
   @w_fecha_tran     = tr_fecha_tran,
   @w_descripcion    = tr_descripcion,
   @w_usuario        = tr_usuario,
   @w_tran           = tr_tran,
   @w_oficina_orig   = tr_oficina_orig,
   @w_oficina_dest   = tr_oficina_dest,
   @w_estado         = tr_estado,
   @w_valor = sum(dtr_valor)
   from  cob_custodia..cu_transaccion, 
         cob_custodia..cu_det_trn
   where tr_secuencial      = @i_secuencial
   and   tr_codigo_externo  = @i_codigo_externo
   and   dtr_secuencial     = tr_secuencial
   and   dtr_codigo_externo = tr_codigo_externo
   group by tr_secuencial,tr_codigo_externo,
             tr_fecha_tran,
             tr_descripcion,
             tr_usuario,
             tr_tran,
             tr_oficina_orig,
             tr_oficina_dest,
             tr_estado

   if @@rowcount > 0
           select @w_existe = 1
   else
            select @w_existe = 0
   end
   else
   begin
   select 
   @w_secuencial     = tr_secuencial,
   @w_codigo_externo = tr_codigo_externo,
   @w_fecha_tran     = tr_fecha_tran,
   @w_descripcion    = tr_descripcion,
   @w_usuario        = tr_usuario,
   @w_tran           = tr_tran,
   @w_oficina_orig   = tr_oficina_orig,
   @w_oficina_dest   = tr_oficina_dest,
   @w_estado         = tr_estado,
   @w_valor = sum(dtr_valor)
   from  cob_custodia..cu_transaccion, 
         cob_custodia..cu_det_trn
   where tr_secuencial      = @i_secuencial
   and   tr_codigo_externo  > "0"
   and   dtr_secuencial     = tr_secuencial
   and   dtr_codigo_externo = tr_codigo_externo
   group by tr_secuencial, tr_codigo_externo,
             tr_fecha_tran,
             tr_descripcion,
             tr_usuario,
             tr_tran,
             tr_oficina_orig,
             tr_oficina_dest,
             tr_estado

   if @@rowcount > 0
           select @w_existe = 1
   else
            select @w_existe = 0
   end   
end

if @i_operacion = 'B'
begin
   set rowcount 20
   if @i_usuario is null
      select @i_usuario = @i_param1

         
    select distinct "LOGIN"=substring(us_login,1,15),
                    "NOMBRE" = substring(fu_nombre,1,30), us_login
     from   cobis..ad_usuario,
            cobis..cl_funcionario
    where   us_login = fu_login
      and   (us_login > @i_usuario or @i_usuario is null)
    order by us_login
   if @@rowcount = 0
   begin
      if @i_usuario is null
      begin
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901003
        return 1 
      end
      else
      begin
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901004
        return 1 
      end    
   end
end


if @i_operacion = 'C'
begin
   select @w_clave = us_login
   from  cobis..ad_usuario
   where us_login = @i_usuario

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901005
      return 1 
   end 
   else
   begin
      select @w_nombre_usr = fu_nombre
      from  cobis..cl_funcionario,cobis..ad_usuario
      where fu_login = @w_clave

      select @w_nombre_usr
   end
end


if @i_operacion = 'Q'
begin
    if @w_existe = 1
       select 
       @w_secuencial,
       @w_codigo_externo,
       @w_fecha_tran,
       @w_descripcion,   
       @w_usuario,
       @w_tran,
       @w_oficina_orig,
       @w_oficina_dest,
       @w_estado,
       @w_valor
    else
    begin
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901005
        return 1 
    end
    return 0
end

if @i_operacion = 'S'
begin
   if @i_modo = 0
   begin

      select 
      @w_valor_inicial = isnull(cu_valor_inicial,0),
      @w_valor_actual  = isnull(cu_valor_actual, isnull(cu_valor_refer_comis,0)),
      @w_codigo_externo = cu_codigo_externo
      from cu_custodia
      where cu_codigo_externo = @i_codigo_externo

      select 
      @w_garante = substring(p_p_apellido + ' ' +
      p_s_apellido + ' ' + en_nombre,1,30)
      from cu_cliente_garantia, cobis..cl_ente
      where cg_codigo_externo = @i_codigo_externo
      and   cg_principal      = 'D'
      and   cg_ente           = en_ente

      select 
      @w_deudor = substring(p_p_apellido + ' ' + 
      p_s_apellido + ' ' + en_nombre,1,30)
      from cob_credito..cr_gar_propuesta,
      cob_credito..cr_deudores,cobis..cl_ente
      where gp_garantia = @i_codigo_externo
      and de_rol       = 'D'
      and gp_tramite = de_tramite
      and de_cliente = en_ente 

      select
      @w_valor_inicial,
      @w_garante,
      @w_deudor,
      @w_valor_actual

   end
   
   if @i_modo = 3  
   begin
      set rowcount 5
      select distinct cg_nombre
      from cu_cliente_garantia
      where (cg_tipo_garante = 'C')
      and   cg_codigo_externo = @i_codigo_externo
           
      select distinct cg_nombre
      from cu_cliente_garantia
      where cg_tipo_garante = 'A'
      and   cg_codigo_externo = @i_codigo_externo
 
      select distinct cg_nombre
      from cu_cliente_garantia
      where cg_tipo_garante = 'J'
      and   cg_codigo_externo = @i_codigo_externo
      
      return 0 
   end
     select @i_operacion = 'F'
end

if @i_operacion = 'F'
begin
   set rowcount 20

   if @i_usuario is not null
   begin
      if @i_secuencial is not null 
      begin
         if @i_codigo_externo is not null
         begin
            if @i_fecha1 is not null --Se controla en front-end @i_fecha1 y @i_fecha2 tienen valor los dos o ninguno
            begin
               select 
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_usuario like @i_usuario 
               and      tr_secuencial > @i_secuencial
               and      dtr_codigo_externo = @i_codigo_externo
               and      tr_fecha_tran   >= @i_fecha1 
               and      tr_fecha_tran   <= @i_fecha2 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end
            else
            begin
               select 
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_usuario like @i_usuario 
               and      tr_secuencial > @i_secuencial
               and      dtr_codigo_externo = @i_codigo_externo
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end             
         end
         else
         begin
            if @i_fecha1 is not null --Se controla en front-end @i_fecha1 y @i_fecha2 tienen valor los dos o ninguno
            begin
               select 
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_usuario like @i_usuario 
               and      tr_secuencial > @i_secuencial
               and      tr_fecha_tran   >= @i_fecha1 
               and      tr_fecha_tran   <= @i_fecha2 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end
            else
            begin
               select 
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_usuario like @i_usuario 
               and      tr_secuencial > @i_secuencial
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
             end
         end         
      end
      else
      begin
         if @i_codigo_externo is not null
         begin
            if @i_fecha1 is not null --Se controla en front-end @i_fecha1 y @i_fecha2 tienen valor los dos o ninguno
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_usuario like @i_usuario 
               and      dtr_codigo_externo = @i_codigo_externo  
               and      tr_fecha_tran   >= @i_fecha1 
               and      tr_fecha_tran   <= @i_fecha2 
               and      dtr_secuencial  = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end
            else
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_usuario like @i_usuario 
               and      dtr_codigo_externo = @i_codigo_externo  
               and      dtr_secuencial  = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
           
            end
         end
         else
         begin
            if @i_fecha1 is not null --Se controla en front-end @i_fecha1 y @i_fecha2 tienen valor los dos o ninguno
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_usuario like @i_usuario 
               and      tr_fecha_tran   >= @i_fecha1 
               and      tr_fecha_tran   <= @i_fecha2 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end
            else
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_usuario like @i_usuario 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end            
         end         
      end      
   end
   else
   begin
      if @i_secuencial is not null 
      begin
         if @i_codigo_externo is not null 
         begin
            if @i_fecha1 is not null --Se controla en front-end @i_fecha1 y @i_fecha2 tienen valor los dos o ninguno
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_secuencial > @i_secuencial 
               and      dtr_codigo_externo = @i_codigo_externo  
               and      tr_fecha_tran   >= @i_fecha1 
               and      tr_fecha_tran   <= @i_fecha2 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end
            else
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_secuencial > @i_secuencial 
               and      dtr_codigo_externo = @i_codigo_externo  
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end            
         end
         else
         begin
            if @i_fecha1 is not null --Se controla en front-end @i_fecha1 y @i_fecha2 tienen valor los dos o ninguno
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_secuencial > @i_secuencial 
               and      tr_fecha_tran   >= @i_fecha1 
               and      tr_fecha_tran   <= @i_fecha2 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end
            else
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_secuencial > @i_secuencial 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end            
         end         
      end
      else
      begin
         if @i_codigo_externo is not null
         begin
            if @i_fecha1 is not null --Se controla en front-end @i_fecha1 y @i_fecha2 tienen valor los dos o ninguno
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    dtr_codigo_externo = @i_codigo_externo  
               and      tr_fecha_tran   >= @i_fecha1 
               and      tr_fecha_tran   <= @i_fecha2 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end
            else
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    dtr_codigo_externo = @i_codigo_externo  
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end            
         end
         else
         begin
            if @i_fecha1 is not null --Se controla en front-end @i_fecha1 y @i_fecha2 tienen valor los dos o ninguno
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    tr_fecha_tran   >= @i_fecha1 
               and      tr_fecha_tran   <= @i_fecha2 
               and      dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end
            else
            begin
               select distinct
               "NRO."           = tr_secuencial,
               "TIPO"           = cu_tipo,
               "GARANTIA"       = cu_custodia,
               "FECHA"          = convert(char(10),tr_fecha_tran,@i_formato_fecha),
               "TIPO TRAN"      = tr_tran, 
               "DESCRIPCION"    = tr_descripcion,
               "VR TRANSACCION" = convert(money,dtr_valor),
               "VR CONTABLE / TRANS" = isnull(cu_valor_cobertura,isnull(cu_valor_refer_comis,0)),  --XTA
               "USUARIO" = tr_usuario
               from     cob_custodia..cu_transaccion, 
                        cob_custodia..cu_det_trn, 
                        cu_custodia
               where    dtr_secuencial = tr_secuencial
               and      dtr_codigo_externo = tr_codigo_externo
               and      cu_codigo_externo  = tr_codigo_externo
               order by tr_secuencial
            end            
         end         
      end
   end   


   set rowcount 0
      

   return 0
end

go