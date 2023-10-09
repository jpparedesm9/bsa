/************************************************************************/
/*	Archivo: 	        credito5.sp                             */ 
/*	Stored procedure:       sp_credito5                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Dado el grupo   entrega los totales de garantias por tipo       */
/*	de garantia  en moneda nacional                                 */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995		     Emision Inicial			*/
/*      Dic/2002        Jvelandia    cambio de etiqueta de valor actual */  
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_credito5')
drop proc sp_credito5
go
create proc sp_credito5  (
   @s_date               datetime    = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_grupo              int         = null, 
   @i_tipo_cust          varchar(64) = null,
   @i_cliente            int         = null,
   @i_ente               int         = null,	--no se ocupa
   @i_codigo_externo     varchar(64) = null,
   @i_tipo_ctz           char(1)     = "B"
)
as

declare
   @w_today              datetime,     /* FECHA DEL DIA */ 
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC*/
   @w_vcu                varchar(64),
   @w_gar                varchar(64),
   @w_gac                varchar(64),
   @w_ayer               datetime,
   @w_nombre             varchar(64),
   @w_valor              money,
   @w_cliente            int,
   @w_contador           tinyint,
   @w_apellido1          varchar(64),
   @w_apellido2          varchar(64),
   @w_def_moneda         tinyint,
   @w_moneda             tinyint,
   @w_return		 int,  
   @w_rowcount           int

select @w_today   = @s_date
select @w_sp_name = 'sp_credito5',
       @w_ayer    = convert(char(10),dateadd(dd,-1,@s_date),101)

/***********************************************************/
/* CODIGO DE TRANSACCIONES                                */

if (@t_trn <> 19394 and @i_operacion = 'S') 
     
begin
/* TIPO DE TRANSACCION NO CORRESPONDE */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 1901006
   return 1 
end

/*SELECCION DE CODIGO DE MONEDA LOCAL*/
select @w_def_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLOCR'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount=0
begin
   /*REGISTRO NO EXISTE*/
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file = @t_file,
   @t_from = @w_sp_name,
   @i_num = 2101005
   return 1
end

if @i_operacion = 'S'
begin
   
   select @w_vcu = pa_char + '%' -- TIPOS SIMPLE CUSTODIA EXCLUIR
   from cobis..cl_parametro
   where pa_producto = 'GAR'
   and pa_nemonico = 'VCU'
   set transaction isolation level read uncommitted

   select @w_gar = pa_char + '%' -- TIPOS DE GARANTIA
   from cobis..cl_parametro
   where pa_producto = 'GAR'
   and pa_nemonico = 'GAR'
   set transaction isolation level read uncommitted

   select @w_gac = pa_char + '%' -- TIPOS DE GARANTIA AL COBRO 
   from cobis..cl_parametro
   where pa_producto = 'GAR'
   and pa_nemonico = 'GAC'
   set transaction isolation level read uncommitted

   if @i_modo = 2
   begin

      create table #cu_grupos (Ente      int          null,
                               Nombre    varchar(64)  null,
                               Valor     money        null)

      declare grupos cursor for
      select distinct en_ente,en_nombre,p_p_apellido,p_s_apellido,
      cu_codigo_externo, cu_valor_inicial, cu_moneda
      from cobis..cl_ente,cu_custodia,cob_credito..cr_gar_propuesta
      where en_grupo        = @i_grupo 
      and en_ente           = gp_deudor
      and gp_garantia       = cu_codigo_externo
      and cu_estado         not in ('A', 'C')  --pga23may2001
      and cu_tipo           = @i_tipo_cust
      order by en_ente
      for read only

      open grupos
      fetch grupos into @w_cliente,@w_nombre,@w_apellido1,@w_apellido2

      if (@@fetch_status != 0 )    --  NO EXISTEN GRUPOS
      begin
         --select * from #cu_grupos
         close grupos
         select * from #cu_grupos
         return 0
      end

      select @w_contador = 1   -- PARA INGRESAR SOLO 20 REGISTROS
      while (@@fetch_status = 0)  and (@w_contador <=20) -- LAZO DE BUSQUEDA

      begin
         select @w_contador = @w_contador + 1
         select @w_valor  = sum(cu_valor_inicial * isnull(cv_valor,1))
         from cob_conta..cb_vcotizacion right outer join cu_custodia on cv_moneda = cu_moneda, 
              cob_credito..cr_gar_propuesta 
         where gp_deudor  = @w_cliente
         and gp_garantia  = cu_codigo_externo
         and cu_estado    not in ('A','C')
         and cu_tipo      = @i_tipo_cust
         and cv_fecha     in (select max(A.cv_fecha)
                                from cob_conta..cb_vcotizacion  A
                               where A.cv_fecha <= @w_today)
         and cu_tipo  not like @w_vcu   

         select @w_valor = isnull(@w_valor,0)
         insert into #cu_grupos values (@w_cliente,
         @w_apellido1+' '+@w_apellido2+' '+@w_nombre, @w_valor)

         fetch grupos into @w_cliente,@w_nombre,@w_apellido1,@w_apellido2

      end   --  FIN DEL WHILE

      if (@@fetch_status = -1)  -- ERROR DEL CURSOR
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1909001 
         return 1 
      end
      close grupos
      deallocate grupos
      select * from #cu_grupos
   end 
   else  -- *****************    TOTALES POR TIPOS    **********************
   begin
      if @i_modo = 1  
      begin
         set rowcount 20
         select substring (tc_tipo,1,15),
         tc_descripcion,
         cu_codigo_externo,
         cu_valor_inicial,
         cu_moneda
         from cu_custodia, cu_tipo_custodia,
         cobis..cl_ente, cob_credito..cr_gar_propuesta
         where en_grupo  = @i_grupo
         and gp_deudor   = en_ente
         and gp_garantia = cu_codigo_externo
         and cu_tipo     = tc_tipo
         and cu_garante   is null   --  EXCLUYE GARANTES PERSONALES
         and cu_estado    not in ('C','A')    
         and cu_tipo not like @w_vcu
         GROUP by tc_tipo,tc_descripcion,cu_codigo_externo, cu_valor_inicial,cu_moneda
         order by tc_tipo,tc_descripcion,cu_codigo_externo, cu_valor_inicial,cu_moneda
         
      end

      if @i_modo = 3  --CODIGO,DESCRIPCION y ESTADO DE UN TIPO
      begin
         set rowcount 20
         select 
         'CODIGO' = a.cu_codigo_externo,
         'DESCRIPCION' = substring(a.cu_descripcion,1,35),
         'ESTADO' = a.cu_estado,
         'VALOR GARANTIA'=a.cu_valor_inicial * isnull(cv_valor,1)
         from cu_custodia a left outer join cu_tipo_custodia on a.cu_tipo = tc_tipo, 
              cob_conta..cb_vcotizacion right outer join cu_custodia b on cv_moneda = b.cu_moneda,
              cobis..cl_ente, cob_credito..cr_gar_propuesta
         where gp_deudor = @i_cliente
         and gp_garantia = a.cu_codigo_externo
         and a.cu_garante  is null   --  EXCLUYE GARANTES PERSONALES
         and a.cu_estado   not in ('C','A')
         and a.cu_tipo     not like @w_vcu
         and cv_fecha    in (select max(A.cv_fecha)
                                   from cob_conta..cb_vcotizacion A
                                   where A.cv_fecha <= @w_today)
         and a.cu_tipo      = @i_tipo_cust
         and (a.cu_codigo_externo>@i_codigo_externo or @i_codigo_externo is null)
         order by a.cu_tipo
      end
      if @@rowcount = 0
      begin
         if (@i_modo = 2 and @i_tipo_cust is null) or 
         (@i_modo = 3 and @i_codigo_externo is null)
         return 1 
         else
         return 0 
      end
   end -- ELSE
end
go

