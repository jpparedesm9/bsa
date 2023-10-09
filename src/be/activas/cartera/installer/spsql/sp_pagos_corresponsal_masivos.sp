/*************************************************************************/
/*   Archivo:            sp_pagos_corresponsal_masivos.sp                */
/*   Stored procedure:   sp_pagos_corresponsal_masivos                   */
/*   Base de datos:      cob_cartera                                     */
/*   Producto:           Cartera                                         */
/*   Disenado por:       Patricio Samueza                                */
/*   Fecha de escritura: 10/04/2019                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa da mantenimiento a la tabla cl_negocio_cliente        */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     I            Creación de una alerta                               */
/*     D            Eliminación (estado E) una operacion inusual (OI)    */
/*     S            Listado todas las OI ingresadas en el día            */
/*     S            Listado las alertas de riesgo ingresadas del día     */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                     RAZON                        */
/* 10/04/2019    PXSG       Versión Inicial                              */
/* 16/01/2019    DCU        Inc. 126891                                  */
/* 16/06/2022    ACH        #185234 se agrega tipo de tran GI, opcion V  */
/*************************************************************************/
use cob_cartera
go
if object_id ('sp_pagos_corresponsal_masivos') is not null
	drop procedure sp_pagos_corresponsal_masivos
go
create proc sp_pagos_corresponsal_masivos (
@s_ssn             int          = 1,
@s_sesn            int          = 1,
@s_date            datetime     = null,
@s_user            login        = null,
@s_term            varchar(30)  = 'consola',
@s_ofi             smallint     = null,
@s_srv             varchar(30)  = 'CTSSRV',
@s_lsrv            varchar(30)  = 'CTSSRV',
@s_rol             smallint     = null,
@s_org             varchar(15)  = null,
@s_culture         varchar(15)  = null,
@t_debug           char(1)      = 'N',
@t_file            varchar(10)  = null,
@t_from            varchar(32)  = null,
@t_trn             smallint     = null,
@i_operacion       char(1),       -- (B)atch, (S)ervicio, (C)onciliacion manual
@i_referencia      varchar(64)  = null, -- no obligatorio para batch
@i_corresponsal    varchar(64)  = null, -- no obligatorio para batch
@i_moneda          int          = 0, -- obligatoria para el servicio
@i_status_srv      varchar(64)  = '', -- obligatoria para el servicio
@i_observacion     varchar(255) = '', -- obligatoria para la conciliacion
@i_fecha_pago      varchar(10)  = null,
@i_monto_pago      varchar(14)  = null,
@i_archivo_pago    varchar(255) = null,
@i_trn_id_corresp  varchar(8)   = null,
@i_accion          char(1)      = null,
@i_en_linea        char(1)      = 'N',
@i_num_fila        int          = null,
@i_delete          char(1)      = 'N',

@o_msg             varchar(255) = null out

   
)as
declare 
   @w_ts_name              varchar(32),
   @w_num_error            int,
   @w_sp_name              varchar(32),
   @w_codigo               int,
   @w_error                int,
   @num_fila_archivo       int,
   @w_observaciones        varchar(800),
   @w_num_referencia       varchar(64) ,
   @w_fecha_pago           varchar(10),
   @w_fecha_proceso        datetime, 
   @w_fecha_pago_date      datetime,
   @w_sp_val_corresponsal  varchar(50), -- nombre del sp que ejecuta la validacion para el corresponsal
   @w_id_corresponsal      varchar(10),
   @w_token_validacion     varchar(255),
   @w_est_vigente          int,
   @w_est_vencido          int,
   @w_est_castigado        int,
   @w_suspenso             int,
   @w_est_diferido         int,
   @w_fecha_pago_str       char(10),
   @w_tipo_tran            varchar(30), -- (GL) Garantia Líquida, (PG) Préstamo Grupal, (PI) Préstamo Individual, 
   @w_codigo_interno       varchar(30), -- codigo de tramite o codigo de grupo segun el tipo de transaccion
   @w_fecha_valor          datetime, ---devuelve la referencia
   @w_monto                money,--devuelve la referencia
   @w_tipo                 char(2),
   @w_monto_pago           varchar(14),
   @w_tramite              int, 
   @w_grupo                int,
   @w_operacion            int,
   @w_fecha_inicio_ope     datetime,
   @w_saldo_exigible       money,
   @w_monto_nomey          money,
   @w_banco                cuenta,
   @w_forma_pago           varchar(64),
   @w_trn_id_corresp       varchar(8),
   @w_archivo_pago         varchar(255),
   @w_numero_reve          varchar(14),
   @w_numero_decimales     int, 
   @w_msg                  varchar(255),
   @w_monto_seguro_basico  money,
   @w_monto_gar_liquida    money
   
   
select @w_sp_name = 'sp_pagos_corresponsal_masivos'


--Operacion para insertara todos los datos del archivo execl.

select @w_fecha_proceso=fp_fecha 
from   cobis..ba_fecha_proceso

exec @w_error    = sp_estados_cca
@o_est_vigente   = @w_est_vigente   out,
@o_est_vencido   = @w_est_vencido   out,
@o_est_cancelado = @w_est_castigado out,
@o_est_diferido  = @w_est_diferido  out,
@o_est_suspenso  = @w_suspenso      out            

--si falla la consulta de estados--
if @w_error <> 0
begin 
   select
   @w_error = 701103,
   @w_msg = 'Error !:ERROR AL CONSULTAR ESTADOS DE CARTERA'
   goto ERROR
end

IF(@i_operacion='I')
begin
    
    if @i_delete='S'
	    --Ingresa eliminado de acuerdo al archivo que ingresa
	DELETE  from cob_cartera..ca_referencia_tmp 
		where   nom_archivo_pago=@i_archivo_pago 

    --Inserto en la tabla
    insert into cob_cartera..ca_referencia_tmp
                (num_fila,          fecha_valor_pago , num_referencia   ,  monto_pago,
                
                 forma_pago,        trn_corresponsal , nom_archivo_pago
                )
     values
                (@i_num_fila,       @i_fecha_pago   ,  @i_referencia     , @i_monto_pago,
                
                 @i_corresponsal ,  @i_trn_id_corresp , @i_archivo_pago
                )
                
      if @@error != 0
        begin
            select @w_error = 70213 -- Error al insertar
            goto ERROR 
        end           
 
end
--Opcion donde se empieza a validar cada uno de los registros
IF(@i_operacion='V')
begin
    PRINT'V'
    if exists(select 1 from cob_cartera..ca_corresponsal_trn where co_archivo_ref=@i_archivo_pago)
    BEGIN
     select @w_error = 70212 -- Error al insertar
     select @o_msg='ERROR: YA EXISTE UN ARCHIVO DE PAGO CON EL MISMO NOMBRE'
     goto ERROR 
    end

    select @num_fila_archivo = 0
    set DATEFORMAT dmy
    
    while 1 = 1 
    begin--Inici While
        set @w_observaciones=''
        set @w_grupo=0
        set @w_operacion=0
        set @w_tipo_tran=''
        set @w_codigo_interno=''
        set @w_fecha_valor=''
        set @w_monto=''   
        set @w_tipo=''
        
        select  TOP 1 @w_fecha_pago     = fecha_valor_pago ,
                      @w_num_referencia = num_referencia,
                      @w_monto_pago     = monto_pago,
                      @w_forma_pago     = forma_pago,
                      @w_trn_id_corresp = trn_corresponsal,
                      @num_fila_archivo = num_fila
        from cob_cartera..ca_referencia_tmp 
        where num_fila > @num_fila_archivo 
        AND   nom_archivo_pago=@i_archivo_pago
        order by num_fila asc
        if @@rowcount = 0 BREAK
         --Validacion forma de pago
          if not exists (select 1 from cob_cartera..ca_producto where cp_producto = @w_forma_pago )  begin
            set @w_observaciones=@w_observaciones+' '+ 'No existe Corresponsal como Forma de Pago'
          end
         --Valido que el monto sea un numero y mayor que cero

           IF (isnumeric(@w_monto_pago)=1)
             BEGIN
          
               IF(convert(MONEY,@w_monto_pago)<0)
               BEGIN
                set @w_observaciones=@w_observaciones+' '+ 'El monto no debe ser negativo'
               END
               
           
               --valido que el monto tenga maximo dos decimales
               
               SET @w_numero_reve=reverse(@w_monto_pago) 
               PRINT '@w_numero_reve'+ convert(VARCHAR(50),@w_numero_reve)
               SET @w_numero_decimales=CHARINDEX('.',@w_numero_reve)-1
               IF(@w_numero_decimales>2)
               BEGIN
       
                set @w_observaciones=@w_observaciones+' '+ 'El monto debe tener máximo dos decimales'
               END
             END
           ELSE
             BEGIN
          
               set @w_observaciones=@w_observaciones+' '+ 'El monto no es un valor válido'
             END
         
         
         --Validacion transaccion de la corresponsal valido que sea un entero
         IF(@w_trn_id_corresp<>NULL or @w_trn_id_corresp<>'')
          BEGIN
           IF (isnumeric(@w_trn_id_corresp)=0)
           BEGIN
           set @w_observaciones=@w_observaciones+' '+ 'El identificador del corresponsal no es un entero'
           END
      END  
        --validacion si la fecha es valida
        if isdate(@w_fecha_pago)=0
        begin
        set @w_observaciones=@w_observaciones+' '+ 'Fecha de pago Inválida '
        end
        ELSE
        begin	
        --la fecha no puede ser mayor a la fecha de proceso de COBIS 
        select @w_fecha_pago_date=CONVERT (datetime,@w_fecha_pago, 103)
        IF(@w_fecha_pago_date>@w_fecha_proceso)
          begin
            set @w_observaciones=@w_observaciones+' '+ 'Fecha de pago no puede ser mayor a la fecha de proceso'
          end 
        
        --BUSCA SP PARA VALIDAR REFERENCIA, DEPENDIENDO DEL CORRESPONSAL
		PRINT 'w_forma_pago: '+convert (VARCHAR(50),@w_forma_pago)
        select  
        @w_sp_val_corresponsal = co_sp_validacion_ref,
        @w_id_corresponsal     = co_id,
        @w_token_validacion    = co_token_validacion
        from cob_cartera..ca_corresponsal 
        where UPPER(co_nombre) = UPPER(@w_forma_pago)
        
        --si no existe el corresponsal en la tabla--

		if @@rowcount = 0
        begin 
        PRINT '4 - @w_sp_val_corresponsal: '+convert (VARCHAR(50),@w_sp_val_corresponsal)
           --select 
          -- @w_error = 70203,
          SET  @w_observaciones=@w_observaciones +' '+'ERROR: NO EXISTE EL CORREPONSAL'
           --goto ERROR
        end
        ELSE
        BEGIN
        select @w_fecha_pago_str =replace(convert(varchar(10),@w_fecha_pago_date,101),'/','')
        --select @w_fecha_pago_str
        
        PRINT @w_num_referencia
        
        IF (isnumeric(@w_monto_pago)=1)
        BEGIN
        exec @w_error     = @w_sp_val_corresponsal
        @i_referencia     = @w_num_referencia,   
        @i_archivo_pago   = '',
        @i_fecha_pago     = @w_fecha_pago_str,
        @i_monto_pago     = @w_monto_pago,
        @i_pagos_masivos  = 'S',
        --@o_tipo_tran      = @w_tipo_tran      out,
        @o_codigo_interno = @w_codigo_interno out,
        @o_fecha_pago     = @w_fecha_valor    out,
        @o_monto_pago     = @w_monto          out,
        @o_tipo           = @w_tipo           out
  
        -- SI FALLA AL VALIDAR LA REFERENCIA O LAS FECHAS DE PAGO
        if @w_error <> 0
          begin 
          PRINT'Error..'+convert (varchar(50),@w_error)
           SELECT  @w_msg=mensaje FROM cobis..cl_errores WHERE numero=@w_error
           set @w_observaciones=@w_observaciones+' '+@w_msg
          end
        end

        PRINT 'w_tipo_tran: '     + convert(VARCHAR(50),@w_tipo_tran)
        PRINT 'w_codigo_interno: '+ convert(VARCHAR(50),@w_codigo_interno)        
        PRINT 'w_fecha_valor: '   + convert(VARCHAR(50),@w_fecha_valor)        
        PRINT 'w_monto: '         + convert(VARCHAR(50),@w_monto)        
        PRINT 'w_tipo: '          + convert(VARCHAR(50),@w_tipo)
        
        IF (@w_tipo<>'GL' and @w_tipo <> 'PG' and @w_tipo<> 'PI' and @w_tipo<> 'CG' AND @w_tipo<> 'CI' AND @w_tipo <> 'GI') --porCaso185234
        begin
        set @w_observaciones=@w_observaciones+' '+ 'El tipo de referencia no es válida'
        end
        
        
        ------ CONSULTA DE GARANTIA LIQUIDA ----------
        IF(@w_tipo='GL')
        begin
        select @w_grupo = convert(int,@w_codigo_interno)
        
        select @w_tramite = io_campo_3 --Trámite Grupal
        from   cob_workflow..wf_inst_proceso
        where  io_campo_1 = @w_grupo  --Nro del grupo
        and    io_campo_7 = 'S'
        and    io_campo_4 = 'GRUPAL'
        and    io_estado  = 'EJE'
        
	    if @@rowcount = 0 begin
	      set @w_observaciones=@w_observaciones+' '+ 'Debe existir un trámite en proceso para el grupo:'+ convert(VARCHAR(50),@w_grupo)
	    end
	
        --	No puede ser menor a la fecha de inicio de la operación.
        select TOP 1 @w_fecha_inicio_ope=op_fecha_ini 
        from cob_cartera..ca_operacion
        where  op_tramite=@w_tramite
        IF(@w_fecha_pago_date<@w_fecha_inicio_ope)
          begin
            set @w_observaciones=@w_observaciones+' '+ 'Fecha de pago no puede ser menor a la fecha de inicio de la operación'
          end
          
        --- OBTIENE EL SALDO PENDIENTE DE PAGO
        
        --Cobro de Seguros 
        select @w_monto_seguro_basico = sum(case when isnull(se_monto,0) <> 0 and isnull(se_monto,0) > isnull(se_monto_pagado,0) then
                                    isnull(se_monto,0)- isnull(se_monto_pagado,0)
                                    else 0 end)
        from cob_cartera..ca_seguro_externo
        where se_tramite = @w_tramite
        
        --Garantia Liquida
        select @w_monto_gar_liquida  = isnull(sum(isnull(gl_monto_garantia,0) - isnull(gl_pag_valor,0)),0) 
        from cob_cartera..ca_garantia_liquida
        where gl_tramite    = @w_tramite
        and   gl_pag_estado = 'PC'
       -- and   isnull(gl_monto_garantia,0) > isnull(gl_pag_valor,0)
        
       select @w_saldo_exigible=isnull(@w_monto_seguro_basico,0)
       
       select @w_saldo_exigible=isnull(@w_saldo_exigible,0)+isnull(@w_monto_gar_liquida,0)
       
        
	    print 'GL SALDO PENDIENTE DE PAGO @w_saldo_exigible>>'+convert(varchar(10),@w_saldo_exigible)
	    
	    if(@w_saldo_exigible=0)
	    begin
	       set @w_observaciones=@w_observaciones+' '+ 'No existe garantía líquida para el trámite ingresado.'
	    end
	    else
	    begin
	    
	    set @w_monto_nomey=convert(money,@w_monto_pago)
	    
	    IF(@w_saldo_exigible<>@w_monto_nomey)
	    begin
	    set @w_observaciones=@w_observaciones+' '+ 'El valor pagado debe ser igual al valor de la garantía líquida mas el seguro'
	    end  
        
        end 
        
        end 
        ELSE
        begin
        
          if  @w_tipo = 'PG' or @w_tipo = 'CG'
            BEGIN
             PRINT '@w_operacion papa PG..'+convert(VARCHAR(50),@w_operacion)
             select @w_operacion = convert(int,@w_codigo_interno)
            
             select TOP 1 @w_grupo=op_cliente
             from cob_cartera..ca_operacion 
             where op_operacion=@w_operacion
             
             PRINT '@w_grupo PG..'+convert(VARCHAR(50),@w_grupo)
            
               select @w_fecha_inicio_ope=op_fecha_ini
                 from cob_cartera..ca_det_ciclo , cob_cartera..ca_ciclo , cob_cartera..ca_operacion
                 where dc_referencia_grupal =  ci_prestamo
                 and op_operacion = dc_operacion
                 and ci_grupo = @w_grupo
                 and op_estado  in (@w_est_vigente,
                                    @w_est_vencido,  
                                    @w_est_castigado,
                                    @w_est_diferido ,
                                    @w_suspenso )
              if @@rowcount = 0 begin 
               set @w_observaciones=@w_observaciones+' '+ 'No existe Préstamo Grupal que acepte pagos'
              end                   
            
              IF(@w_fecha_pago_date<@w_fecha_inicio_ope)
              begin
                set @w_observaciones=@w_observaciones+' '+ 'Fecha de pago no puede ser menor a la fecha de inicio de la operación'
              end      
            end
          
          if  @w_tipo = 'PI' or @w_tipo = 'CI'
            begin
             PRINT '@w_operacion..'+convert(VARCHAR(50),@w_operacion)
             select @w_operacion = convert(int,@w_codigo_interno)
     
             select TOP 1 @w_fecha_inicio_ope=op_fecha_ini 
             from cob_cartera..ca_operacion 
             where op_operacion=@w_operacion
             
              IF(@w_fecha_pago_date<@w_fecha_inicio_ope)
              begin
                set @w_observaciones=@w_observaciones+' '+ 'Fecha de pago no puede ser menor a la fecha de inicio de la operación'
              end 
          
             select 
             @w_banco     = op_banco
             from  cob_cartera..ca_operacion
             where op_operacion= @w_operacion
             AND op_estado IN (@w_est_vigente,
                                 @w_est_vencido,  
                                 @w_est_castigado,
                                 @w_est_diferido ,
                                 @w_suspenso )  
              if @@rowcount = 0 begin 
               set @w_observaciones=@w_observaciones+' '+ 'No existe Préstamo Individual que acepte pagos'
              end                    
                                   
            end
          
        
          end--fin de else GL
        
          end--fin else de sp de pago corresponsal
        end--fin else de la fecha valida
        
        --PRINT @w_observaciones
         --Actualiza las observaciones si existen
        UPDATE cob_cartera..ca_referencia_tmp
        set observaciones =@w_observaciones
        where num_fila    =@num_fila_archivo
        AND   nom_archivo_pago=@i_archivo_pago
        
                     
    end--Fin while

        select 'NumFila'         = num_fila,         
               'FechaPago'       = fecha_valor_pago,
               'NumReferencia'   = num_referencia , 
               'MontoPago'       = monto_pago ,     
               'FormaPago'       = forma_pago ,     
               'TrnCorresponsal' = trn_corresponsal,
               'NombreArchivo'   = nom_archivo_pago,
               'Observaciones'   = observaciones   
        
        from
        cob_cartera..ca_referencia_tmp
        where nom_archivo_pago=@i_archivo_pago




end

IF(@i_operacion='P')
begin
PRINT'P'

    select @num_fila_archivo = 0  
    set DATEFORMAT dmy
    
    while 1 = 1 
     BEGIN
          PRINT'b' 
        select  TOP 1 @w_fecha_pago     = fecha_valor_pago ,
                      @w_num_referencia = num_referencia,
                      @w_monto_pago     = monto_pago,
                      @w_forma_pago     = forma_pago,
                      @w_trn_id_corresp = trn_corresponsal,
                      @w_archivo_pago   = nom_archivo_pago,
                      @num_fila_archivo = num_fila
        from cob_cartera..ca_referencia_tmp 
        where num_fila > @num_fila_archivo
        AND   nom_archivo_pago=@i_archivo_pago 
        order by num_fila asc
        if @@rowcount = 0 BREAK
        
       select @w_fecha_pago_date=CONVERT (datetime,@w_fecha_pago, 103)
       select @w_fecha_pago_str =replace(convert(varchar(10),@w_fecha_pago_date,101),'/','')
        
       BEGIN TRY
        exec @w_error     = cob_cartera..sp_pagos_corresponsal
        @i_operacion      = 'I',
        @i_accion         = 'I',
        @i_referencia     = @w_num_referencia,
        @i_corresponsal   = @w_forma_pago,
        @i_fecha_pago     = @w_fecha_pago_str,
        @i_monto_pago     = @w_monto_pago,
        @i_archivo_pago   = @w_archivo_pago,
        @i_trn_id_corresp = @w_trn_id_corresp,
        @i_co_linea       = @num_fila_archivo,
        @i_pagos_masivos  = 'S',
        @s_user           =  @s_user
		
       if @w_error <> 0 begin
             PRINT'@w_error'+convert(VARCHAR(50),@w_error)
	     print'Error  sp_pagos_corresponsal opcion P  referencias ' +convert(varchar(50),@w_num_referencia)
		 print'Error l sp_pagos_corresponsal opcion P @num_fila_archivo ' +convert(varchar(50),@num_fila_archivo)
		 print'Error l sp_pagos_corresponsal opcion P @w_archivo_pago    ' +convert(varchar(50),@w_archivo_pago )
          select @w_msg = 'Error al ejecutar el sp_pagos_corresponsal'
          
          UPDATE cob_cartera..ca_referencia_tmp SET procesado='N'
          WHERE num_fila        = @num_fila_archivo
          AND   nom_archivo_pago= @w_archivo_pago
          
          --GOTO ERROR
	   end
        else
        begin
         IF(@w_trn_id_corresp IS NULL or @w_trn_id_corresp='')
          BEGIN 
          UPDATE cob_cartera..ca_corresponsal_trn SET co_trn_id_corresp=co_secuencial
          WHERE co_referencia  = @w_num_referencia
          AND   co_archivo_ref = @w_archivo_pago
          END 
        
          UPDATE cob_cartera..ca_referencia_tmp SET procesado='S'
          WHERE num_fila        = @num_fila_archivo
          AND   nom_archivo_pago= @w_archivo_pago
          end
          
        END TRY
        
        BEGIN CATCH
        print'@w_error catch'+convert(VARCHAR(50),@w_error)
        print'Error  sp_pagos_corresponsal opcion P  referencias catch ' +convert(varchar(50),@w_num_referencia)
		print'Error l sp_pagos_corresponsal opcion P @num_fila_archivo catch ' +convert(varchar(50),@num_fila_archivo)
		print'Error l sp_pagos_corresponsal opcion P @w_archivo_pago  catch  ' +convert(varchar(50),@w_archivo_pago )
		
        UPDATE cob_cartera..ca_referencia_tmp SET procesado='N'
          WHERE num_fila        = @num_fila_archivo
          AND   nom_archivo_pago= @w_archivo_pago
        
        print'pasa la actualizacion estado N'
        
        END CATCH
        
    
     END
     /*if not exists (SELECT 1 FROM cob_cartera..ca_referencia_tmp 
                        WHERE nom_archivo_pago = @w_archivo_pago
                        AND   procesado='N')
        begin
        
          delete  from cob_cartera..ca_referencia_tmp 
		  where   nom_archivo_pago=@i_archivo_pago
    
     end         */        
                        


end

--Operacion para devolver los datos procesados
IF(@i_operacion='Q')
BEGIN

     select 'NumProcesados'  = isnull(count(*),0),
            'MontoProcesado' = isnull(sum(convert(MONEY,co_monto)),0),
            'NumNoProcesados'=isnull( (SELECT  isnull(count(*),0) 
                                       FROM   cob_cartera..ca_referencia_tmp
                                       WHERE nom_archivo_pago=@i_archivo_pago) 
                                       -(SELECT isnull(count(*),0)
                                       FROM cob_cartera..ca_corresponsal_trn 
                                       WHERE co_archivo_ref=@i_archivo_pago)
                                     ,0)
     from cob_cartera..ca_corresponsal_trn 
     where co_archivo_ref =@i_archivo_pago

END

return 0
ERROR:
    begin --Devolver mensaje de Error
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error
        return @w_error
    end
GO

