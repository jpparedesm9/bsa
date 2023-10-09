/************************************************************************/
/*	Archivo:                cliente.sp                              */
/*	Stored procedure:       sp_cliente_garantia                     */
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
/*	Permite realizar el Ingreso, Modificacion, Borrado, Consulta y  */
/*      Busqueda de los clientes atados a las Garantias.                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*       Jun/1995  L. Castellanos    Emision Inicial		        */
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cliente_garantia')
    drop proc sp_cliente_garantia
go
create proc sp_cliente_garantia (
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_filial             tinyint  = null,
   @i_sucursal           smallint  = null,
   @i_custodia           int  = null,
   @i_tipo_cust          descripcion  = null,
   @i_ente               int  = null,
   @i_principal          char(1) = null,
   @i_cliente            int = null,
   @i_oficial            int = null,
   @i_nomcliente         varchar(64) = null,
   @i_tipo_garante       catalogo =null,
   @i_codigo_externo     cuenta	= null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_secservicio        int,
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_custodia           int,
   @w_tipo_cust          descripcion,
   @w_ente               int,
   @w_principal          char(1),
   @w_error              int,
   @w_codigo_externo     varchar(64),
   @w_cliente            varchar(64),
   @w_oficial            int,
   @w_nomcliente	 varchar(255),
   @w_tipo		 varchar(20)

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_cliente_garantia'

/***********************************************************/

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
   select 
   @w_filial         = cg_filial,
   @w_sucursal       = cg_sucursal,
   @w_custodia       = cg_custodia,
   @w_tipo_cust      = cg_tipo_cust,
   @w_ente           = cg_ente,
   @w_codigo_externo = cg_codigo_externo,
   @w_oficial        = cg_oficial
   from cob_custodia..cu_cliente_garantia
   where 
   cg_filial         = @i_filial and
   cg_sucursal       = @i_sucursal and
   cg_tipo_cust      = @i_tipo_cust and
   cg_custodia       = @i_custodia and
   cg_ente           = @i_ente           

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
   if @i_filial is NULL or @i_sucursal is NULL or 
   @i_custodia is NULL or @i_tipo_cust is NULL or 
   @i_ente is NULL 
   begin
    /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1
   begin
   /* Registro ya existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901002
      return 1 
   end
   -- pga20may2001
   select @w_secservicio = @@spid

   begin tran
      exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
      @w_codigo_externo out
      insert into cu_cliente_garantia(
      cg_filial, cg_sucursal, cg_custodia,
      cg_tipo_cust, cg_ente, cg_principal,
      cg_codigo_externo, cg_oficial, cg_tipo_garante,
      cg_nombre)		--NVR-BE
      values (
      @i_filial, @i_sucursal, @i_custodia,
      @i_tipo_cust, @i_ente, @i_principal,
      @w_codigo_externo, @i_oficial, @i_tipo_garante,
      @i_nomcliente)		--NVR-BE
     

      if @@error <> 0 
      begin
      /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
      end

      insert into ts_cliente_garantia
      values (
      @w_secservicio,@t_trn,'N',
      @s_date,@s_user,@s_term,
      @s_ofi,'cu_cliente_garantia', @i_filial,
      @i_sucursal, @i_tipo_cust, @i_custodia,
      @i_ente, @i_principal, @w_codigo_externo)

      if @@error <> 0 
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903003
         return 1 
      end
   commit tran 
   return 0
end

/* Eliminacion de registros */
/****************************/
if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
    /* Registro a eliminar no existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1907002
      return 1 
   end

/***** Integridad Referencial *****/
/*****                        *****/
   -- pga 20may2001
   select @w_secservicio = @@spid

   begin tran
      delete cob_custodia..cu_cliente_garantia
      where 
      cg_filial = @i_filial and
      cg_sucursal = @i_sucursal and
      cg_tipo_cust = @i_tipo_cust and
      cg_custodia = @i_custodia and
      cg_ente = @i_ente

                          
      if @@error <> 0
      begin
      /*Error en eliminacion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1907001
         return 1 
      end

      if @i_principal = 'D'  -- SE TRATA DEL PRINCIPAL  LAL DE S
      begin 
         set rowcount 1
         update cu_cliente_garantia
         set cg_principal    = 'D'  -- (S)i DEUDOR
         where cg_filial     = @i_filial 
         and cg_sucursal   = @i_sucursal
         and cg_tipo_cust  = @i_tipo_cust
         and cg_custodia   = @i_custodia 
         set rowcount 0

         if @@error <> 0
         begin
            /*Error en eliminacion de registro */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1905001
            return 1 
         end
      end

         /* Transaccion de Servicio */
         /***************************/

      insert into ts_cliente_garantia
      values (
      @w_secservicio,@t_trn,'B',
      @s_date,@s_user,@s_term,
      @s_ofi,'cu_cliente_garantia', @w_filial,
      @w_sucursal, @w_tipo_cust, @w_custodia,
      @w_ente, NULL, @w_codigo_externo)

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903003
         return 1 
      end
   commit tran
   return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
   if @w_existe = 1
      select 
      @w_filial,
      @w_sucursal,
      @w_custodia,
      @w_tipo_cust,
      @w_ente,
      @w_oficial
   else
   begin
    /*Registro no existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901005
      return 1 
   end
   return 0
end

if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0 
   begin
      select
      "ENTE" = en_ente,
      "NOMBRE" = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,
      "DI/NIT" = substring(en_ced_ruc,1,20),
      "GERENTE" = cg_oficial,
      "PRINCIPAL" = cg_principal
      from cobis..cl_ente,cu_cliente_garantia   
      where cg_filial = @i_filial and
      cg_sucursal = @i_sucursal and
      cg_tipo_cust = @i_tipo_cust and
      cg_custodia = @i_custodia and
      cg_ente = en_ente 
      order by en_ente
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end
   end
   else 
   begin
      select
      "ENTE" = en_ente,
      "NOMBRE" = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,
      "DI/NIT" = en_ced_ruc, 
      "GERENTE" = cg_oficial  
      from cobis..cl_ente,cu_cliente_garantia   
      where cg_ente > @i_ente and
      cg_filial = @i_filial and
      cg_sucursal = @i_sucursal and
      cg_tipo_cust = @i_tipo_cust and
      cg_custodia = @i_custodia and
      cg_ente = en_ente 
      order by en_ente
      if @@rowcount = 0
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
   set rowcount 20
    select 
   "COD. CLIENTE"  = cg_ente,	
   "CLIENTE" = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,  	
   "TIPO DE GARANTE" = B.valor, -- cg_tipo_garante,	
   "No.IDENTIFICACION"     = en_ced_ruc,
   "GERENTE"    = F.fu_nombre,   --cg_oficial,  
   "GRUPO ECONOMICO"    = en_grupo,    
   "CALIFICACION"  = en_calificacion,
   "COMPARTIDA"    = cu_compartida 	
   from cu_cliente_garantia
            inner join cu_custodia on
            cg_filial       = @i_filial
            and cg_sucursal       = @i_sucursal
            and cg_tipo_cust      = @i_tipo_cust 
            and cg_custodia       = @i_custodia 
            and cg_codigo_externo = cu_codigo_externo
                   inner join cobis..cl_ente on
                   cg_ente           = en_ente
                   and (cg_ente > @i_cliente 
                   or @i_cliente is null)
                          inner join cobis..cl_catalogo B on  
                           B.codigo = cg_tipo_garante
                                inner join cobis..cl_tabla A on
                                A.tabla= 'cu_tipo_garante'	
                                and A.codigo = B.tabla                                                             
                                     inner join cobis..cc_oficial  O on --PGA 10may2001
                                     en_oficial = O.oc_oficial  
                                        inner join cobis..cl_funcionario F on
                                        O.oc_funcionario = F.fu_funcionario -- pga 10may2001
                                              left outer join  cobis..cl_grupo G on
                                              en_grupo = G.gr_grupo


   order by cg_tipo_cust,cg_custodia,cg_ente
   if @@rowcount = 0
   begin
           /*exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003*/
      return 1 
   end
   return 0 
end

if @i_operacion = 'V'
begin
   if exists (select  * 
      from cu_cliente_garantia,cobis..cl_ente
      where cg_filial = @i_filial
      and cg_sucursal = @i_sucursal
      and (cg_tipo_cust = @i_tipo_cust or @i_tipo_cust is null)
      and (cg_custodia = @i_custodia  or @i_custodia is null)
      and cg_ente = @i_cliente
      and cg_ente = en_ente)
   begin
      return 0
   end
   else
   begin
           /*exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901004*/
      return 1 
   end
end       

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
   if not exists (select * from cu_cliente_garantia
                  where cg_filial    =   @i_filial     
                  and cg_sucursal  =   @i_sucursal   
                  and cg_tipo_cust =   @i_tipo_cust  
                  and cg_custodia  =   @i_custodia)  
    begin
    /* Registro a actualizar no existe */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905002
       return 1 
    end

    -- pga20may2001
    select @w_secservicio = @@spid

    begin tran
       exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
       @w_codigo_externo out

       update cob_custodia..cu_cliente_garantia set
       cg_ente      = @i_ente,
       cg_nombre      = @i_nomcliente
       where  cg_filial    = @i_filial and
       cg_sucursal  = @i_sucursal and
       cg_tipo_cust = @i_tipo_cust and
       cg_custodia  = @i_custodia  

       if @@error <> 0 
       begin
         /* Error en actualizacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
       end

         /* Transaccion de Servicio */
         /***************************/

       insert into ts_cliente_garantia
       values (
       @w_secservicio,@t_trn,'P',
       @s_date,@s_user,@s_term,
       @s_ofi,'cu_cliente_garantia', @w_filial,
       @w_sucursal, @w_tipo_cust, @w_custodia,
       @w_ente, NULL, @w_codigo_externo)

       if @@error <> 0 
       begin
         /* Error en insercion de transaccion de servicio */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903003
          return 1 
      end
            

         /* Transaccion de Servicio */
         /***************************/
      -- PGA 20mar2001
         select @w_secservicio = @@spid
--              @i_garantia    = @w_codigo_externo

      insert into ts_cliente_garantia
      values (
      @w_secservicio,@t_trn,'A',
      @s_date,@s_user,@s_term,
      @s_ofi,'cu_cliente_garantia', @i_filial,
      @i_sucursal, @i_tipo_cust, @i_custodia,
      @i_ente, NULL, @w_codigo_externo)

      if @@error <> 0 
      begin
      /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903003
         return 1 
      end
   commit tran
   return 0
end


/* Declaracion de cursor */
/*if @i_operacion = 'Z'
begin
   
   create table cu_cliente_temporal (
   filial     tinyint,
   sucursal   smallint,
   tipo       varchar(64),
   custodia   int,
   cliente    int,
   nombre     varchar(64)
   )
   

   declare cliente_garantia cursor
   for
   select cu_tipo,cu_custodia
   from cu_custodia        
   where cu_filial    = @i_filial
   and cu_sucursal  = @i_sucursal
   for read only

   open cliente_garantia
   fetch cliente_garantia into @w_tipo_cust,
                                @w_custodia

   while @@fetch_status = 0
   begin
      insert into cu_cliente_temporal
      select
      cg_filial,cg_sucursal,cg_tipo_cust,
      cg_custodia,cg_ente,cg_nombre 
      from cu_cliente_garantia,cu_custodia  --,cobis..cl_ente   
      where cg_filial            = @i_filial
      and cg_sucursal          = @i_sucursal
      and cg_tipo_cust         = @w_tipo_cust
      and cg_custodia          = @w_custodia
      and cg_codigo_externo    = cu_codigo_externo
      and (cg_ente <> @i_cliente) 
      fetch cliente_garantia into @w_tipo_cust,
                                 @w_custodia
   end
   deallocate cursor cliente_garantia
   close cursor cliente_garantia

   select
   "FILIAL" = cg_filial,
   "SUCURSAL" = cg_sucursal,
   "TIPO" = tipo,
   "GARANTIA" = custodia,
   "COD. CLIENTE" = cliente,
   "CLIENTE" = nombre 
   from cu_cliente_temporal,cu_cliente_garantia 
   drop table cu_cliente_temporal
end */

if @i_operacion = 'E'
begin
   set rowcount 1
   select @w_cliente = cg_nombre
   from cu_cliente_garantia
   where cg_filial            = @i_filial
   and cg_sucursal          = @i_sucursal
   and cg_tipo_cust         = @i_tipo_cust
   and cg_custodia          = @i_custodia 
   and cg_tipo_garante = 'C'
   if @@rowcount = 0
   begin
      return 1
   end
   select @w_cliente
end 
   
if @i_operacion = 'M'
begin
   select	"COD. CLIENTE"  	= cg_ente,	
   		"ROL" 	= cg_tipo_garante,
   		"IDENTIFICACION"	= en_ced_ruc,
   		"CLIENTE" = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
   from 	cobis..cl_ente,
		cu_cliente_garantia
   where 	cg_ente = en_ente 
   and		cg_codigo_externo	= @i_codigo_externo
end

if @i_operacion = 'R'
begin
   if @i_tipo_garante = 'A'
   begin
         if exists(select 1
             	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	= @i_codigo_externo
         	   and	  cg_ente		= @i_ente
         	   and	  cg_tipo_garante       IN('J'))
         begin
         if not exists(select 1
           	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	= @i_codigo_externo
         	   and	  cg_tipo_garante       IN('C'))
            begin
               print 'Favor ingresar Primero un Propietario (C/J)'
               return 0
            end
         end

         if exists(select 1
             	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	= @i_codigo_externo
         	   and	  cg_ente		= @i_ente
         	   and	  cg_tipo_garante       IN('C'))
         begin
         if not exists(select 1
           	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	= @i_codigo_externo
         	   and	  cg_tipo_garante       IN('J'))
            begin
               print 'Favor ingresar Primero un Propietario (C/J)'
               return 0
            end
         end


         delete	cob_custodia..cu_cliente_garantia
         where	cg_codigo_externo	= @i_codigo_externo
         and	cg_ente			= @i_ente

         select @w_nomcliente  	= en_nomlar
         from	cobis..cl_ente
         where	en_ente 	= @i_ente
 
         exec sp_compuesto
         @t_trn       = 19245,
         @i_operacion = 'Q',
         @i_compuesto = @i_codigo_externo,
         @o_filial    = @w_filial out,
         @o_sucursal  = @w_sucursal out,
         @o_tipo      = @w_tipo out,
         @o_custodia  = @w_custodia out


         select	@i_oficial 	= en_oficial
	 from	cobis..cl_ente
         where 	en_ente 	= @i_ente

         exec sp_cliente_garantia 
         @t_trn 	= 19040,
         @i_operacion 	= 'I',
         @i_filial 	= @w_filial,
         @i_sucursal 	= @w_sucursal, 
         @i_tipo_cust 	= @w_tipo,
         @i_custodia 	= @w_custodia,
         @i_ente 	= @i_ente,
         @i_principal 	= 'C',
         @i_oficial 	= @i_oficial  ,
         @i_tipo_garante= 'A',
         @i_nomcliente 	=  @w_nomcliente 

   end

   if @i_tipo_garante = 'J'
   begin
         delete	cob_custodia..cu_cliente_garantia
         where	cg_codigo_externo	= @i_codigo_externo
         and	cg_ente			= @i_ente

         update	cob_custodia..cu_cliente_garantia
         set	cg_tipo_garante		= 'A',
         	cg_principal 		= 'C'
         where	cg_codigo_externo	= @i_codigo_externo
         and	cg_tipo_garante		in('J','C')
        
         select @w_nomcliente  	= en_nomlar
         from	cobis..cl_ente
         where	en_ente 	= @i_ente
 
         exec sp_compuesto
         @t_trn       = 19245,
         @i_operacion = 'Q',
         @i_compuesto = @i_codigo_externo,
         @o_filial    = @w_filial out,
         @o_sucursal  = @w_sucursal out,
         @o_tipo      = @w_tipo out,
         @o_custodia  = @w_custodia out

         select	@i_oficial 	= en_oficial
	 from	cobis..cl_ente
         where 	en_ente 	= @i_ente
 
         exec sp_cliente_garantia 
         @t_trn 	= 19040,
         @i_operacion 	= 'I',
         @i_filial 	= @w_filial,
         @i_sucursal 	= @w_sucursal, 
         @i_tipo_cust 	= @w_tipo,
         @i_custodia 	= @w_custodia,
         @i_ente 	= @i_ente,
         @i_principal 	= 'D',
         @i_oficial 	= @i_oficial  ,
         @i_tipo_garante= 'J',
         @i_nomcliente 	=  @w_nomcliente 
   end

   if @i_tipo_garante = 'C'
   begin

         if exists(select 1
             	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	= @i_codigo_externo
         	   and	  cg_ente		= @i_ente
         	   and	  cg_tipo_garante       IN('J'))
         begin
         if not exists(select 1
           	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	= @i_codigo_externo
         	   and	  cg_tipo_garante       IN('A'))
            begin
               print 'Favor ingresar Primero un Garantizado (A)'
               return 0
            end
         end

         if exists(select 1
             	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	= @i_codigo_externo
         	   and	  cg_ente		= @i_ente
         	   and	  cg_tipo_garante       IN('C'))
         begin
         if not exists(select 1
           	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	= @i_codigo_externo
         	   and	  cg_tipo_garante       IN('A'))
            begin
               print 'Favor ingresar Primero un Garantizado (A)'
               return 0
            end
         end


         update	cob_custodia..cu_cliente_garantia
         set	cg_tipo_garante		= 'A',
         	cg_principal 		= 'C'
         where	cg_codigo_externo	= @i_codigo_externo
         and	cg_tipo_garante		in('C','J')

         delete	cob_custodia..cu_cliente_garantia
         where	cg_codigo_externo	= @i_codigo_externo
         and	cg_ente			= @i_ente

         select @w_nomcliente  	= en_nomlar
         from	cobis..cl_ente
         where	en_ente 	= @i_ente
 
         exec sp_compuesto
         @t_trn       = 19245,
         @i_operacion = 'Q',
         @i_compuesto = @i_codigo_externo,
         @o_filial    = @w_filial out,
         @o_sucursal  = @w_sucursal out,
         @o_tipo      = @w_tipo out,
         @o_custodia  = @w_custodia out
 
         select	@i_oficial 	= en_oficial
	 from	cobis..cl_ente
         where 	en_ente 	= @i_ente

         exec sp_cliente_garantia 
         @t_trn 	= 19040,
         @i_operacion 	= 'I',
         @i_filial 	= @w_filial,
         @i_sucursal 	= @w_sucursal, 
         @i_tipo_cust 	= @w_tipo,
         @i_custodia 	= @w_custodia,
         @i_ente 	= @i_ente,
         @i_principal 	= 'D',
         @i_oficial 	= @i_oficial  ,
         @i_tipo_garante= 'C',
         @i_nomcliente 	=  @w_nomcliente 

   end


end


if @i_operacion = 'B'
begin

   select	@i_tipo_garante = cg_tipo_garante	         
   from 	cob_custodia..cu_cliente_garantia
   where	cg_codigo_externo	= @i_codigo_externo
   and		cg_ente			= @i_ente


   if @i_tipo_garante = 'A'
   begin
         if not exists(select 1
             	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	=  @i_codigo_externo
         	   and	  cg_ente		<> @i_ente
         	   and	  cg_tipo_garante       IN ('J','A'))
         begin
            print 'No existe garantizado'
            return 0
         end

         delete	cob_custodia..cu_cliente_garantia
         where	cg_codigo_externo	= @i_codigo_externo
         and	cg_ente			= @i_ente
   end

   if @i_tipo_garante = 'J'
   begin
         if not exists(select 1
             	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	=  @i_codigo_externo
         	   and	  cg_ente		<> @i_ente
         	   and	  cg_tipo_garante       IN ('A')) 
         begin
            print 'No existe garantizado '
            return 0
         end

         if not exists(select 1
             	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	=  @i_codigo_externo
         	   and	  cg_ente		<> @i_ente
         	   and	  cg_tipo_garante       IN ('C')) 
         begin
            print 'No existe propietario'
            return 0
         end


         delete	cob_custodia..cu_cliente_garantia
         where	cg_codigo_externo	= @i_codigo_externo
         and	cg_ente			= @i_ente
   end


   if @i_tipo_garante = 'C'
   begin
         if not exists(select 1
             	   from	  cob_custodia..cu_cliente_garantia
         	   where  cg_codigo_externo	=  @i_codigo_externo
         	   and	  cg_ente		<> @i_ente
         	   and	  cg_tipo_garante       IN ('J')) 
         begin
            print 'No existe garantizado o propietario'
            return 0
         end

         delete	cob_custodia..cu_cliente_garantia
         where	cg_codigo_externo	= @i_codigo_externo
         and	cg_ente			= @i_ente
   end



end



return 0
error:    /* Rutina que dispara sp_cerror dado el codigo de error */

            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1 

                                                                                                                             
go
