/************************************************************************/
/*	Archivo:                recupera.sp                             */
/*	Stored procedure:       sp_recuperacion                         */  
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
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Ingreso / Modificacion / Eliminacion / Consulta y Busqueda de   */
/*	las Recuperaciones realizadas a los vencimientos de una Garantia*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		        Emision Inicial			*/
/*      Octubre/2002   Gonzalo S.       Parametro tipo de garantia      */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_recuperacion')
    drop proc sp_recuperacion
go
create proc sp_recuperacion (
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
   @i_tipo_cust          descripcion  = null,
   @i_custodia           int  = null,
   @i_recuperacion       smallint  = null,
   @i_valor              money  = null,
   @i_vencimiento        smallint  = null,
   @i_fecha              datetime  = null,
   @i_formato_fecha      int = null,       --PGA 16/06/2000
   @i_cobro_vencimiento	 float = null, 		--money = null,
   @i_cobro_mora         money = null,
   @i_cobro_comision     money = null,
   @i_saldo		 money = null,
   @i_num_acciones       float = null,
   @i_valor_accion       money = null,
   @i_bandera            int = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo_cust          descripcion,
   @w_custodia           int,
   @w_recuperacion       smallint,
   @w_secservicio        int,
   @w_valor              money,
   @w_valor_vencimiento  money,
   @w_vencimiento        smallint,
   @w_fecha              datetime,
   @w_ultimo             smallint,
   @w_error              int,
   @w_des_tipo           descripcion,
   @w_debcred            char(1),
   @w_descripcion        descripcion,
   @w_valor_comision     money,
   @w_valor_mora         money,
   @w_cobro_vencimiento  float, 	--money,
   @w_cobro_mora         money,
   @w_cobro_comision     money,
   @w_valor_aux          money,
   @w_valor_absoluto     money,
   @w_dias_mora          smallint,
   @w_fecha_vencimiento  datetime,
   @w_status             int,
   @w_suma_ven           float,		--money,
   @w_suma_saldos        float,		--money,
   @w_suma_rec           float,		--money,
   @w_diferencia         float,		--money,
   @w_codigo_externo     varchar(64),
   @w_estado_gar         char(1),
   @w_beneficiario       varchar(64),
   @w_saldo_recuperar    float,		--money,            
   @w_num		 smallint,
   @w_valor_vcto	 float,		--money,
   @w_saldo		 float,		--money,
   @w_recuperad          smallint,
   @w_resta  		 float,
   @w_valor_comercial    money,
   @w_cuantia		 char(1),
   @w_secuencial         int,
   @w_vcuacc             varchar(30)

select @w_today = convert(varchar(10),@s_date,101) 	
select @w_sp_name = 'sp_recuperacion'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19020 and @i_operacion = 'I') or
   (@t_trn <> 19021 and @i_operacion = 'U') or
   (@t_trn <> 19022 and @i_operacion = 'D') or
   (@t_trn <> 19023 and @i_operacion = 'V') or
   (@t_trn <> 19024 and @i_operacion = 'S') or
   (@t_trn <> 19025 and @i_operacion = 'Q') or
   (@t_trn <> 19026 and @i_operacion = 'A') or
   (@t_trn <> 19027 and @i_operacion = 'Z')

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

select @w_secservicio = @@spid

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
    select 
         @w_filial = re_filial,
         @w_sucursal = re_sucursal,
         @w_tipo_cust = re_tipo_cust,
         @w_custodia = re_custodia,
         @w_recuperacion = re_recuperacion,
         @w_valor = re_valor,
         @w_vencimiento = re_vencimiento,
         @w_fecha = re_fecha,
         @w_cobro_mora = re_cobro_mora,
         @w_cobro_comision = re_cobro_comision,
         @w_codigo_externo = re_codigo_externo
    from cob_custodia..cu_recuperacion
    where 
         re_filial = @i_filial and
         re_sucursal = @i_sucursal and
         re_tipo_cust = @i_tipo_cust and
         re_custodia = @i_custodia and
         re_vencimiento  = @i_vencimiento and
         re_recuperacion = @i_recuperacion


    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if @i_filial is NULL or 
       @i_sucursal is NULL or 
       @i_tipo_cust is NULL or 
       @i_custodia is NULL or 
       @i_valor is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
    end

    exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                    @w_codigo_externo out

    select @w_cobro_vencimiento = isnull(sum(ve_valor),0)
    from cu_vencimiento
    where ve_codigo_externo = @w_codigo_externo 

    select @w_cuantia = cu_cuantia
    from cu_custodia
    where cu_codigo_externo = @w_codigo_externo 

    if @w_cuantia = 'I' 
    begin
       select @w_valor_comercial = isnull(cu_valor_inicial,isnull(cu_valor_refer_comis,0))
       from cu_custodia
       where cu_codigo_externo = @w_codigo_externo 
    end
    else
    begin
       select @w_valor_comercial = isnull(cu_vlr_cuantia,isnull(cu_valor_refer_comis,0))
       from cu_custodia
       where cu_codigo_externo = @w_codigo_externo 
    end
    
    if @i_fecha < @s_date  -- MVI aumentado para control 07/02/96
    begin 
    /* La fecha de recuperacion debe ser mayor o igual a la fecha actual */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1903010
        return 1 
    end 
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
 
   exec sp_externo
   @i_filial, @i_sucursal, @i_tipo_cust,
   @i_custodia, @w_codigo_externo out 

   -- PGA 8mar2001
   exec @w_secuencial = sp_gensec

   begin tran       
      if not exists(select * from cu_vencimiento
         where ve_codigo_externo = @w_codigo_externo  )
         return 1
      else 
      begin
         /* NO RECUPERAR SI LA GARANTIA ESTA PROPUESTA */
         select @w_estado_gar = cu_estado
         from   cu_custodia
         where  cu_codigo_externo = @w_codigo_externo
        
         if @w_estado_gar = 'P'
         begin
         /* No se puede recuperar una garantia con un estado de Propuesta */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1903009
            return 1
         end

         /* NO RECUPERAR SI LA GARANTIA ESTA CANCELADA */
         if @w_estado_gar = 'C'
         begin
         /* No se puede recuperar una garantia con un estado Cancelada */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901015
            return 1
         end
         /* OBTENER EL VALOR TOTAL DE LAS RECUPERACIONES ANTERIORES */

         select @w_suma_rec    = isnull(sum(re_valor),0)
         from   cu_recuperacion
         where  re_codigo_externo  = @w_codigo_externo  

         /*  CONTROLA QUE EL VALOR A RECUPERAR NO SEA MAYOR QUE EL SALDO
             DE LOS VENCIMIENTOS */  --AO

 
         if @i_valor > (@w_cobro_vencimiento - @w_suma_rec)
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1903014   
            return 1
         end
      end 

      select 
      @w_debcred     = 'D',
      @w_descripcion = 'RECUPERACION DEL VENCIMIENTO # '

     /*RECUPERAR LAS GARANTIAS RESTANTES*/


        declare recuperacion cursor for
        select ve_valor, ve_vencimiento
        from   cu_vencimiento
        where  ve_codigo_externo = @w_codigo_externo
	and (ve_vencimiento = @i_vencimiento or @i_vencimiento is null) 
        order by ve_vencimiento
        for read only

	open recuperacion
        fetch recuperacion
        into @w_valor_vcto, @w_vencimiento

        if @@fetch_status != 0     --  No existen vencimientos
        begin
           close recuperacion
           exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 1901003
           return 1 -- No existen registros 
        end
        while (@@fetch_status = 0)  -- Lazo de busqueda
        begin
           /*TOTAL DE RECUPERACIONES DEL VENCIMIENTO ACTUAL*/
        
           select @w_suma_rec = isnull(sum(re_valor),0)
           from   cu_recuperacion
           where  re_codigo_externo = @w_codigo_externo
           and    re_vencimiento    = @w_vencimiento

           if  @w_suma_rec = @w_valor_vcto  
              fetch recuperacion into @w_valor_vcto, @w_vencimiento
           else
              begin      
                /*VALOR RESTANTE POR RECUPERAR*/
                select @w_saldo = @w_valor_vcto - @w_suma_rec 
            
                /* SI EL VALOR A RECUPERAR ES MAYOR AL SALDO DEL VENCIMIENTO */
                  
                if (@i_valor < @w_saldo)
                   select  @w_saldo = @i_valor
            
                 select @i_valor = @i_valor - @w_saldo  
            
                /*GENERA NUMERO RECUPERACION*/
     
                select @w_ultimo =(select isnull(max(re_recuperacion),0)+ 1
                  from cu_recuperacion
                 where re_codigo_externo = @w_codigo_externo
                   and re_vencimiento    = @w_vencimiento)

              /* INSERCION DEL REGISTRO*/
              /*************************/ 
               insert into cu_recuperacion( 
               re_filial,        re_sucursal,         re_tipo_cust,
               re_custodia,      re_recuperacion,     re_valor,
               re_vencimiento,   re_fecha,            re_cobro_vencimiento,
               re_cobro_mora,    re_cobro_comision,   re_codigo_externo,
               re_saldo)
               values (
               @i_filial,        @i_sucursal,         @i_tipo_cust,
               @i_custodia,      @w_ultimo,           @w_saldo,
               @w_vencimiento,   @i_fecha,            @i_cobro_vencimiento,
               @i_cobro_mora,    @i_cobro_comision,   @w_codigo_externo,
               @w_valor_vcto - @w_suma_rec - @w_saldo) 

               if @@error <> 0 
               begin
              /* Error en insercion de registro */ 
                  exec cobis..sp_cerror
                  @t_from  = @w_sp_name,
                  @i_num   = 1903001
                  return 1 
               end

               select 
               @w_descripcion = @w_descripcion + convert(varchar(20),@w_vencimiento)

               /* INGRESO DE LA TRANSACCION */
               /*****************************/
               
              /* LAZG 24 OCT 2002 */
 		select
 		@w_vcuacc = pa_char
 		from cobis..cl_parametro
 		where pa_producto = "GAR"
 		and   pa_nemonico = "VCUACC"
                set transaction isolation level read uncommitted
 		  
             if @i_tipo_cust <> @w_vcuacc
             begin
                 if @i_bandera = 1 
                 begin
                    select @s_user = 'crebatch',
                           @s_term = 'consola'
                 end
		
               exec @w_status = sp_modvalor
               @i_operacion   = 'I',
               @i_filial      = @i_filial,
               @i_sucursal    = @i_sucursal,
               @i_tipo_cust   = @i_tipo_cust,
               @i_custodia    = @i_custodia,
               @i_fecha_tran  = @i_fecha,
               @i_debcred     = @w_debcred, 
               @i_valor       = @w_saldo,
               @i_descripcion = @w_descripcion,
               @i_usuario     = @s_user,
               @i_terminal    = @s_term,
	       @i_nuevo_comercial = @w_valor_comercial,
	       @i_recuperacion = 'S',
               @i_secuencial  = @w_secuencial  --PGA 8mar2001

               select @w_descripcion = 'RECUPERACION DEL VENCIMIENTO # ' 

               if @w_status <> 0 
               begin
               /* Error en insercion de Registro Contable */
                  exec cobis..sp_cerror
                  @t_from  = @w_sp_name,
                  @i_num   = @w_status
                  return 1 
               end
             end 
             else 	--tipo VCUACC   
             begin

		select @i_num_acciones=cu_num_acciones,
			@i_valor_accion=cu_valor_accion
                from cu_custodia
                where cu_codigo_externo=@w_codigo_externo

                if @i_bandera = 1 
                begin
                    select @s_user = 'crebatch',
                           @s_term = 'consola'
                end
		
               exec @w_status = sp_modvalor
               @i_operacion   = 'I',
               @i_filial      = @i_filial,
               @i_sucursal    = @i_sucursal,
               @i_tipo_cust   = @i_tipo_cust,
               @i_custodia    = @i_custodia,
               @i_fecha_tran  = @i_fecha,
               @i_debcred     = @w_debcred, 
               @i_valor       = @w_saldo,
               @i_descripcion = @w_descripcion,
               @i_usuario     = @s_user,
               @i_terminal    = @s_term,
               @i_num_acciones = @i_num_acciones,
               @i_valor_accion = @i_valor_accion,
               @i_nuevo_comercial = @w_valor_comercial,
	       @i_recuperacion = 'S',
               @i_secuencial = @w_secuencial  --PGA 8mar2001

               select @w_descripcion = 'RECUPERACION DEL VENCIMIENTO # ' 
               if @w_status <> 0 
               begin
               /* Error en insercion de Registro Contable */
                  exec cobis..sp_cerror
                  @t_from  = @w_sp_name,
                  @i_num   = @w_status
                  return 1 
               end
	      end

               /* TRANSACCION DE SERVICIO */
               /***************************/
              -- PGA mar2001
              -- exec @w_secservicio = sp_gen_sec

               insert into ts_recuperacion
               values ( 
               @w_secservicio,         @t_trn,                 'N',
               @s_date,                @s_user,                @s_term,
               @s_ofi,                 'cu_recuperacion',      @i_filial,
               @i_sucursal,            @i_tipo_cust,           @i_custodia,
               @i_recuperacion,        @w_saldo,               @w_vencimiento,
               @i_fecha,               @i_cobro_vencimiento,   @i_cobro_mora,
               @i_cobro_comision,      @w_codigo_externo) 
               if @@error <> 0 
               begin
               /* Error en insercion de transaccion de servicio */
                  exec cobis..sp_cerror
                  @t_from  = @w_sp_name,
                  @i_num   = 1903003
                  return 1 
               end 
               
              select @w_secservicio = @w_secservicio + 1
           /*CUANDO SE TERMINE EL VALOR INGRESADO PARA RECUPERAR*/
   
             if @i_valor <= 0 
             begin 
                close recuperacion
                deallocate recuperacion
                commit tran 
                return 0
              end

           fetch recuperacion into @w_valor_vcto, @w_vencimiento
           end
        end  --  FIN DEL WHILE STATUS
          if (@@fetch_status = -1)  -- ERROR DEL CURSOR
          begin
             exec cobis..sp_cerror           
             @t_from  = @w_sp_name,
            @i_num   = 1909001
          return 1
      end
      close recuperacion
      deallocate recuperacion
   commit tran 	--DE LA OPERACION I
return 0
end	--FIN de la OPERACION I

/* Actualizacion del registro */
/******************************/
/* OPCION NO USADA */

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1 
    end

    begin tran

         exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                         @w_codigo_externo out

         update cob_custodia..cu_recuperacion
         set 
              re_valor = @i_valor,
              re_vencimiento = @i_vencimiento,
              re_fecha = @i_fecha,
              re_codigo_externo = @w_codigo_externo
         where 
         re_filial = @i_filial and
         re_sucursal = @i_sucursal and
         re_tipo_cust = @i_tipo_cust and
         re_custodia = @i_custodia and
         re_recuperacion = @i_recuperacion

         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end


         /* Transaccion de Servicio */
         /***************************/
         -- PGA 14mar2001
         -- exec @w_secservicio = sp_gen_sec
         insert into ts_recuperacion
         values (@w_secservicio,@t_trn,'A',@s_date,@s_user,
         @s_term,@s_ofi,'cu_recuperacion',
         @i_filial,
         @i_sucursal,
         @i_tipo_cust,
         @i_custodia,
         @i_recuperacion,
         @i_valor,
         @i_vencimiento,
         @i_fecha,
         null,
         null,
         null,
         @w_codigo_externo) 

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
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
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1 
    end


    exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                    @w_codigo_externo out

    select @w_cuantia = cu_cuantia
    from cu_custodia
    where cu_codigo_externo = @w_codigo_externo 

    if @w_cuantia = 'I' 
    begin
       select @w_valor_comercial = isnull(cu_valor_inicial,isnull(cu_valor_refer_comis,0))
       from cu_custodia
       where cu_codigo_externo = @w_codigo_externo 
    end
    else
    begin
       select @w_valor_comercial = isnull(cu_vlr_cuantia,isnull(cu_valor_refer_comis,0))
       from cu_custodia
       where cu_codigo_externo = @w_codigo_externo 
    end

/***** Integridad Referencial *****/
/*****                        *****/
    begin tran
                                  
         /* Generacion de la transaccion monetaria */
          select 
          @w_debcred = 'C',
          @w_descripcion = 'REVERSION DE RECUPERACION DEL VENCIMIENTO # ' + convert(varchar(20),@i_vencimiento)

          select @w_valor_absoluto = abs (@i_valor)

         exec @w_return = sp_modvalor
         @i_operacion   = 'I',
         @i_filial      = @i_filial,
         @i_sucursal    = @i_sucursal,
         @i_tipo_cust   = @i_tipo_cust,
         @i_custodia    = @i_custodia,
         @i_fecha_tran  = @s_date,
         @i_debcred     =  @w_debcred,
         @i_valor       = @w_valor_absoluto,
         @i_descripcion = @w_descripcion,
         @i_usuario     = @s_user,
         @i_terminal    = @s_term,
         @i_nuevo_comercial = @w_valor_comercial,
	 @i_recuperacion = 'S',
         @i_secuencial = @w_secuencial 
         if @w_return <> 0
         begin
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = @w_return
             return 1 
         end

         delete cob_custodia..cu_recuperacion
         where 
         re_filial = @i_filial and
         re_sucursal = @i_sucursal and
         re_tipo_cust = @i_tipo_cust and
         re_custodia = @i_custodia and
         re_vencimiento  = @i_vencimiento and 
         re_recuperacion = @i_recuperacion
                           
                                          
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1907001
             return 1 
         end

            

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_recuperacion
         values (@w_secservicio,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,'cu_recuperacion',
         @w_filial,
         @w_sucursal,
         @w_tipo_cust,
         @w_custodia,
         @w_recuperacion,
         @w_valor,
         @w_vencimiento,
         @w_fecha,
         @i_cobro_vencimiento,
         @i_cobro_mora,
         @i_cobro_comision,
         @w_codigo_externo) 

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
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

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
    begin

         select @w_saldo_recuperar = sum(re_valor)
	   from cob_custodia..cu_recuperacion
	  where re_filial      = @w_filial 
            and re_sucursal    = @w_sucursal 
            and re_tipo_cust   = @w_tipo_cust 
            and re_custodia    = @w_custodia
       	    and re_vencimiento = @w_vencimiento 

         select @w_des_tipo = tc_descripcion
           from cu_tipo_custodia
          where tc_tipo = @i_tipo_cust

         select @w_fecha_vencimiento = ve_fecha,
                @w_valor_vencimiento = ve_valor,
                @w_beneficiario      = ve_beneficiario
           from cu_vencimiento 
          where ve_filial      = @w_filial 
            and ve_sucursal    = @w_sucursal
            and ve_tipo_cust   = @w_tipo_cust 
            and ve_custodia    = @w_custodia
            and ve_vencimiento = @w_vencimiento

	 select @w_saldo_recuperar = @w_valor_vencimiento - @w_saldo_recuperar 
        
         select 
              @w_filial,
              @w_sucursal,
              @w_tipo_cust,
              @w_des_tipo,
              @w_custodia,              --5
              @w_recuperacion,
              convert(char(10),@w_fecha,@i_formato_fecha),
              @w_valor,
              @w_vencimiento,
              convert(char(10),@w_fecha_vencimiento,@i_formato_fecha),   --10
              @w_cobro_mora,
              @w_cobro_comision,
              @w_valor_vencimiento,
              @w_beneficiario,
	      @w_saldo_recuperar         --15
    end
    else
    begin
      /* Registro consultado no existe */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901005
         return 1 
    end
end

if @i_operacion = 'S'
begin 

   select "RECUPERACION"=re_recuperacion,
	  "FECHA"=convert(char(10),re_fecha,@i_formato_fecha),
          "VALOR RECUPERADO"=convert(money,re_valor),
          "VENCIMIENTO" = re_vencimiento,
          "SALDO"=re_saldo	
     from cu_recuperacion
    where re_filial    = @i_filial
      and re_sucursal  = @i_sucursal
      and re_tipo_cust = @i_tipo_cust
      and re_custodia  = @i_custodia
      and (re_recuperacion > @i_recuperacion or @i_recuperacion is null)

         if @@rowcount = 0
         begin
            if @i_recuperacion is null  
               select @w_error  = 1901003
            else
               return 1
               --select @w_error  = 1901004
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1
        end
end

if @i_operacion = 'Z'
begin

    select @w_cobro_vencimiento = ve_valor 
      from cu_vencimiento
     where ve_filial      = @i_filial 
       and ve_sucursal    = @i_sucursal
       and ve_tipo_cust   = @i_tipo_cust
       and ve_custodia    = @i_custodia
       and ve_vencimiento = @i_vencimiento

    select @w_valor_aux = @w_cobro_vencimiento - sum(re_valor) - @i_valor
      from cu_recuperacion
     where re_filial      = @i_filial 
       and re_sucursal    = @i_sucursal
       and re_tipo_cust   = @i_tipo_cust
       and re_custodia    = @i_custodia
       and re_vencimiento = @i_vencimiento
    
    if @w_valor_aux < 0  -- La recuperacion excede el valor del vencimiento
    begin
    /* Campos NOT NULL con valores nulos 
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1905003 */
        return 1 
    end
    else
        return 0 
 end
go