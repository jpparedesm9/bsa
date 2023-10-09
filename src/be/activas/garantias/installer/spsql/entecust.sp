/************************************************************************/
/*	Archivo: 	        entecust.sp                             */ 
/*	Stored procedure:       sp_ente_custodia                        */ 
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
/*      Consulta de Clientes de Garantias, Consulta de Cuentas          */
/*      Corrientes y de Ahorros de un Cliente y verificacion de Numeros */
/*      de Cuentas                                                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_ente_custodia')
    drop proc sp_ente_custodia
go
create proc sp_ente_custodia  (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_ente               int      = null,
   @i_oficial            int      = null,
   @i_ente1              int      = null,
   @i_ente2              int      = null,
   @i_ente3              int      = null,
   @i_nombre             descripcion = null,
   @i_ced_ruc            varchar(30) = null,
   @i_cuenta             varchar(20) = null,
   @i_tipo_ente          char(1)     = null,
   @i_cond1              varchar(8)  = null,
   @i_cond2              varchar(8)  = null,  --NVR1
   @i_param1             varchar(8)  = null,
   @i_codigo_externo     varchar(64) = null,
   @o_tipo_cta           char(3)     = null out
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_ente1              int,     
   @w_ente2              int,      
   @w_cliente            int,          /* NVR1 */
   @w_nombre             descripcion,
   @w_ced_ruc            varchar(30),
   @w_tipo_cta           char(3),
   @w_tipocta            char(3),
   @w_codigo_externo     varchar(64),
   @w_datoA               int,		--NVR2
   @w_datoC               int,		--NVR2
   @w_oficial 		  smallint,   /*XVE*/ 
   @w_nom_oficial	 varchar(64),  /*XVE*/ 
   @w_rowcount           int


select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_ente_custodia'

/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 19140 and @i_operacion = 'S') or
   (@t_trn <> 19141 and @i_operacion = 'V') or
   (@t_trn <> 19142 and @i_operacion = 'C') or
   (@t_trn <> 19142 and @i_operacion = 'E') or  /*NVR1*/
   (@t_trn <> 19143 and @i_operacion = 'M') or
   (@t_trn <> 19144 and @i_operacion = 'B') or
   (@t_trn <> 19144 and @i_operacion = 'A') or  /*NVR1*/
   (@t_trn <> 19145 and @i_operacion = 'O') or
   (@t_trn <> 19145 and @i_operacion = 'D') or  /* PHsc1 */
   (@t_trn <> 19146 and @i_operacion = 'Z') or
   (@t_trn <> 19147 and @i_operacion = 'R') or  /*XVE*/
   (@t_trn <> 19148 and @i_operacion = 'N')

     
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0 
   begin
      select 
      "ENTE" = en_ente,"NOMBRE" = p_p_apellido + ' ' + p_s_apellido + ' ' 
             + en_nombre,
      "CEDULA" = en_ced_ruc,
      "GERENTE" = en_oficial
      from cobis..cl_ente
      where (en_ente >= @i_ente1 or @i_ente1 is null) and
      (en_ente <= @i_ente2 or @i_ente2 is null) and 
      (p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre like @i_nombre
       or @i_nombre is null) and
      (en_ced_ruc like @i_ced_ruc or @i_ced_ruc is null) and
      (en_subtipo = @i_tipo_ente or @i_tipo_ente is null)
      order by en_ente
      select @w_rowcount = @@rowcount
      set transaction isolation level read uncommitted

      if @w_rowcount = 0
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
      "NOMBRE" = p_p_apellido + ' ' + p_s_apellido + ' '      + en_nombre,
      "CEDULA" = en_ced_ruc, 
      "GERENTE" = en_oficial  
      from cobis..cl_ente
      where
      (en_ente > @i_ente3) and
      (en_ente >= @i_ente1 or @i_ente1 is null) and
      (en_ente <= @i_ente2 or @i_ente2 is null) and
      (p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre like @i_nombre 
       or @i_nombre is null) and
      (en_ced_ruc like @i_ced_ruc or @i_ced_ruc is null) and
      (en_subtipo = @i_tipo_ente or @i_tipo_ente is null)
      order by en_ente
      select @w_rowcount = @@rowcount
      set transaction isolation level read uncommitted

      if @w_rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901004
         return 1 
      end
   end
end



if @i_operacion = 'V'
begin
   select p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
   from cobis..cl_ente
   where 
   en_ente = @i_ente
   select @w_rowcount = @@rowcount
   set transaction isolation level read uncommitted

   if @w_rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end

end


if @i_operacion = 'N'
begin
/*   select
      @w_oficial = en_oficial,
      @w_nom_oficial = fu_nombre
   from cobis..cl_ente, cobis..cl_funcionario
   where en_ente = @i_ente
   and en_oficial = fu_funcionario
   set transaction isolation level read uncommitted

*/

/* PGA 7mar2001 */
   select
      @w_oficial = en_oficial,
      @w_nom_oficial = fu_nombre
  from cobis..cl_ente, cobis..cl_funcionario, cobis..cc_oficial
   where en_ente         = @i_ente
      and en_oficial     = oc_oficial
      and oc_funcionario = fu_funcionario
      select @w_rowcount = @@rowcount
      set transaction isolation level read uncommitted

   if @w_rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num = 1901003
      return 1
   end
   select @w_oficial, @w_nom_oficial
end



if @i_operacion = 'C'
begin
   select @w_datoA=0
   select @w_datoC=0
   create table #losclientes(
   codigo     int,
   nombre     varchar(25))

   insert into #losclientes
   select cg_ente, cg_nombre
   from   cu_cliente_garantia
   where cg_custodia=convert(int,@i_cond1)
   and   cg_tipo_cust=@i_cond2
   if @@error <> 0 
    begin
      /* Error en insercion de registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903001
      return 1 
     end

   declare cuentas_clientes2 cursor for
   select codigo,nombre
   from #losclientes
   for read only

   open cuentas_clientes2
   
   fetch cuentas_clientes2 into @w_cliente, @w_nombre

   while @@fetch_status = 0
   begin

        /*if not exists (select 1
			from cob_cuentas..cc_ctacte 
            where cc_cliente = @w_cliente 
        and cc_cta_banco = @i_cuenta)*/
        exec cob_interfase..sp_verifica_cuenta_cte
        @i_operacion = 'VCTE2',
        @i_cuenta    = @i_cuenta,
        @i_cliente   = @w_cliente,
        @o_existe    = @w_existe
        if not exists (select @w_existe)
		select @w_datoC=@w_datoC+1
        else
        begin
	   select @w_datoC=0
           break
        end
        /*if not exists (select 1
			from cob_ahorros..ah_cuenta
			where ah_cliente = @w_cliente
        and ah_cta_banco = @i_cuenta)*/
        exec cob_interfase..sp_verifica_cuenta_aho
        @i_operacion = 'VAHO2',
        @i_cuenta    = @i_cuenta,
        @i_cliente   = @w_cliente,
        @o_existe    = @w_existe
        if not exists (select @w_existe)
		select @w_datoA=@w_datoA+1
        else 
        begin
	   select @w_datoA=0
           break
        end

      fetch cuentas_clientes2 into @w_cliente,@w_nombre

  end --del while
   close cuentas_clientes2
   deallocate cuentas_clientes2

if @w_datoA <> 0 and @w_datoC <> 0  
begin
     --Print "Cuenta no corresponde a ningun cliente de la garantia"
     exec cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = 1901035
     return 1 
end

end



if @i_operacion = 'E'
begin
   select @w_tipo_cta = ''  
   /*if exists (select 1 
              from cob_cuentas..cc_ctacte
              where cc_cliente   = @i_ente  and
   cc_cta_banco = @i_cuenta)*/
   exec cob_interfase..sp_verifica_cuenta_cte
        @i_operacion = 'VCTE2',
        @i_cuenta    = @i_cuenta,
        @i_cliente   = @i_ente,
        @o_existe    = @w_existe
    if exists (select @w_existe)
   begin
      select @w_tipo_cta = 'CTE'   
   end    
   /*if exists (select 1
                   from cob_ahorros..ah_cuenta
                  where ah_cliente = @i_ente
   and ah_cta_banco = @i_cuenta)*/
   exec cob_interfase..sp_verifica_cuenta_aho
        @i_operacion = 'VAHO2',
        @i_cuenta    = @i_cuenta,
        @i_cliente   = @w_cliente,
        @o_existe    = @w_existe
    if exists (select @w_existe)
    begin 
         select @w_tipo_cta = 'AHO'   
    end
    if @w_tipo_cta = ''
    begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901008
         return 1 
    end
   select @o_tipo_cta = @w_tipo_cta
   select @o_tipo_cta
end 


if @i_operacion = 'M'
begin
   /*if exists (select * from cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cuenta)*/
   exec cob_interfase..sp_verifica_cuenta_aho
        @i_operacion = 'VAHO4',
        @i_cuenta    = @i_cuenta,
        @o_existe    = @w_existe
   if exists (select @w_existe)
      return 0 
   else
   begin
      /*if exists (select * from cob_cuentas..cc_ctacte
      where cc_cta_banco = @i_cuenta) */
      exec cob_interfase..sp_verifica_cuenta_cte
        @i_operacion = 'VCTE4',
        @i_cuenta    = @i_cuenta,
        @o_existe    = @w_existe
   if exists (select @w_existe)
         return 0
      else
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901008
         return 1 
      end
   end 
end


/* PGA 22mar2001 
if @i_operacion = 'B'
begin
   create table #clientes(
   codigo     int,
   nombre     varchar(25))

   insert into #clientes
   select cg_ente, cg_nombre
   from   cu_cliente_garantia
   where cg_custodia=convert(int,@i_cond1)
   and   cg_tipo_cust=@i_cond2
   if @@error <> 0 
    begin
      /* Error en insercion de registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903001
      return 1 
     end



   create table #cuentas(cliente int,
                         nombre varchar(25),
                         tipocta  varchar(3),
                         numero   varchar(24),
                         categoria char(1))


   declare cuentas_clientes cursor for
   select codigo,nombre
   from #clientes
   for read only
   
   open cuentas_clientes
   fetch cuentas_clientes into @w_cliente, @w_nombre

   while @@fetch_status = 0
   begin
        /*if exists (select 1
              from cob_cuentas..cc_ctacte
        where cc_cliente = @w_cliente)*/
        exec cob_interfase..sp_verifica_cuenta_cte
            @i_operacion = 'VCTE2',
            @i_cliente    = @w_cliente,
            @o_existe    = @w_existe
        if exists (select @w_existe)
        begin
              select @w_tipocta = 'CTE'
              insert into #cuentas
              select @w_cliente,@w_nombre,@w_tipocta,cc_cta_banco,cc_categoria
              from cob_cuentas..cc_ctacte
              where cc_cliente = @w_cliente

	      if @@error <> 0 
	       begin
	        /* Error en insercion de registro */
	        exec cobis..sp_cerror
	        @t_from  = @w_sp_name,
	        @i_num   = 1903001
	        return 1 
	       end


        end

        /*if exists (select 1
              from cob_ahorros..ah_cuenta
        where ah_cliente = @w_cliente)*/
        exec cob_interfase..sp_verifica_cuenta_aho
        @i_operacion = 'VAHO2',
        @i_cliente    = @w_cliente,
        @o_existe    = @w_existe
        if exists (select @w_existe)
        begin                
            select @w_tipocta = 'AHO'
              insert into #cuentas
              select @w_cliente,@w_nombre,@w_tipocta,ah_cta_banco,ah_categoria
              from cob_ahorros..ah_cuenta
              where ah_cliente = @w_cliente

	      if @@error <> 0 
	       begin
	       /* Error en insercion de registro */
	       exec cobis..sp_cerror
	       @t_from  = @w_sp_name,
	       @i_num   = 1903001
	       return 1 
	      end


        end


      fetch cuentas_clientes into @w_cliente,@w_nombre

   end --del while
   close cuentas_clientes
   deallocate cuentas_clientes

  select distinct
   "TIPO CUENTA"   = tipocta,
   "NUMERO CUENTA" = numero,
   "CATEGORIA"     = categoria,
   "CLIENTE"   = cliente,
   "NOMBRE"   = nombre
   from #cuentas
   if @@rowcount = 0      
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1
   end
end
PGA 22mar2001 */


if @i_operacion = 'B'
begin

   create table #cuentas(tipocta  varchar(3),
                         numero   varchar(24),
                         categoria char(1))   --FPL2
     select @i_ente = convert(int,@i_cond1)

-- ZR
   /*if exists (select 1
              from cob_cuentas..cc_ctacte
   where cc_cliente = @i_ente)  */
   exec cob_interfase..sp_verifica_cuenta_cte
        @i_operacion = 'VCTE2',
        @i_cliente    = @w_cliente,
        @o_existe    = @w_existe
   if exists (select @w_existe)
   begin
      select @w_tipocta = 'CTE'
      insert into #cuentas
      select @w_tipocta,cc_cta_banco,cc_categoria
      from cob_cuentas..cc_ctacte
      where cc_cliente = @i_ente
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905001
       return 1 
      end




   end
--FIN ZR 
   /*if exists (select 1
              from cob_ahorros..ah_cuenta
   where ah_cliente = @i_ente)*/
   exec cob_interfase..sp_verifica_cuenta_aho
        @i_operacion = 'VAHO2',
        @i_cliente    = @w_cliente,
        @o_existe    = @w_existe
   if exists (select @w_existe)
   begin
      select @w_tipocta = 'AHO'
      insert into #cuentas
      select @w_tipocta,ah_cta_banco,ah_categoria --FPL2
      from cob_ahorros..ah_cuenta
      where ah_cliente = @i_ente

      if @@error <> 0 
      begin
       /* Error en insercion de registro */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905001
       return 1 
      end

   end
   select
   "TIPO CUENTA"   = tipocta,
   "NUMERO CUENTA" = numero,
   "CATEGORIA"     = categoria    --FPL2
   from #cuentas
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end 
end



if @i_operacion = 'A'
begin
   create table #clientesaval(
   codigo     int,
   nombre     varchar(25))


   insert into #clientesaval
   select en_ente, en_nomlar
   from   cobis..cl_ente
   where en_ente=convert(int,@i_cond1)
   if @@error <> 0 
    begin
      /* Error en insercion de registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903001
      return 1 
     end



   create table #cuentasaval(cliente int,
                         nombre varchar(25),
                         tipocta  varchar(3),
                         numero   varchar(24),
                         categoria char(1))


   declare cuentas_clientes cursor for
   select codigo,nombre
   from #clientesaval
   for read only
   
   open cuentas_clientes
   fetch cuentas_clientes into @w_cliente, @w_nombre

   while @@fetch_status = 0
   begin
        /*if exists (select 1
              from cob_cuentas..cc_ctacte
        where cc_cliente = @w_cliente*/
        exec cob_interfase..sp_verifica_cuenta_cte
            @i_operacion = 'VCTE2',
            @i_cliente    = @w_cliente,
            @o_existe    = @w_existe
        if exists (select @w_existe)
        begin
              select @w_tipocta = 'CTE'
              insert into #cuentasaval
              select @w_cliente,@w_nombre,@w_tipocta,cc_cta_banco,cc_categoria
              from cob_cuentas..cc_ctacte
              where cc_cliente = @w_cliente
	      if @@error <> 0 
 	      begin
	      /* Error en insercion de registro */
	      exec cobis..sp_cerror
	      @t_from  = @w_sp_name,
	      @i_num   = 1905001
	      return 1 
	      end



        end

        /*if exists (select 1
              from cob_ahorros..ah_cuenta
        where ah_cliente = @w_cliente)*/
        exec cob_interfase..sp_verifica_cuenta_aho
            @i_operacion = 'VAHO2',
            @i_cliente    = @w_cliente,
            @o_existe    = @w_existe
        if exists (select @w_existe)
        begin                
            select @w_tipocta = 'AHO'
              insert into #cuentasaval
              select @w_cliente,@w_nombre,@w_tipocta,ah_cta_banco,ah_categoria
              from cob_ahorros..ah_cuenta
              where ah_cliente = @w_cliente

	      if @@error <> 0 
	      begin
	      /* Error en insercion de registro */
	      exec cobis..sp_cerror
	      @t_from  = @w_sp_name,
	      @i_num   = 1905001
	      return 1 
 	      end


        end


      fetch cuentas_clientes into @w_cliente,@w_nombre

   end --del while
   close cuentas_clientes
   deallocate cuentas_clientes

  select distinct
   "TIPO CUENTA"   = tipocta,
   "NUMERO CUENTA" = numero,
   "CATEGORIA"     = categoria,
   "CLIENTE"   = cliente,
   "NOMBRE"   = nombre
   from #cuentasaval

   if @@rowcount = 0      
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1
   end
end



if @i_operacion = 'O'
begin
   select 
   "NOMBRE" = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
   from cobis..cl_ente
   where en_ente        = @i_ente
   select @w_rowcount = @@rowcount
   set transaction isolation level read uncommitted
	
   if @w_rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
end



if @i_operacion = 'Z'
begin
   select fu_nombre
   from cobis..cc_oficial,cobis..cl_funcionario
   where oc_oficial     = convert(smallint,@i_oficial) --emg Ene-16-01 optimizacion
   and oc_funcionario   = fu_funcionario
   select @w_rowcount = @@rowcount
   set transaction isolation level read uncommitted

   if @w_rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
end

if @i_operacion = 'R'
begin
   if @i_oficial is null
      select @i_oficial = convert(int,@i_param1)

   set rowcount 20
   select 
   "GERENTE"        = oc_oficial,
   "NOMBRE GERENTE" = fu_nombre
   from cobis..cl_funcionario,cobis..cc_oficial
   where oc_funcionario = fu_funcionario
   and (oc_oficial > convert(smallint,@i_oficial) or @i_oficial is null) 
   order by oc_oficial
   select @w_rowcount = @@rowcount
   set transaction isolation level read uncommitted

   if @w_rowcount = 0
   begin
      if @i_oficial is null
      begin
      /*Registro no existe */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end
      else
      begin
      /*Registro no existe */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901004
         return 1 
      end  
   end
end
go
