/************************************************************************/
/*      Archivo:                consop.sp                               */
/*      Stored procedure:       sp_cons_ini_operacion                   */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las consultas de las   */
/*      operaciones de plazos fijos.                                    */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*                                                                      */
/*    05/31/2001 Ricardo Alvarez     Optimizacion Sybase12              */
/*    06/26/2001 Dolores Guerrero    Tablas temporales e indice x opera-*/
/*                                   cion, estado y accion siguiente    */
/*    29-Nov-2002 N. Silva           Cambios por nueva Renovacion ASB   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_ini_operacion')
   drop proc sp_cons_ini_operacion
go

create proc sp_cons_ini_operacion (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_num_banco            cuenta          = '0',
@i_codigo               varchar(30)     = '%',
@i_accion_sgte          catalogo        = null,
@i_estado1              catalogo        = 'ACT',
@i_estado2              catalogo        = 'VEN',
@i_estado3              catalogo        = null,
@i_operacion            char(1)         = null,
@i_ente                 int             = NULL,
@i_renovada             char(1)         = 'N',
@i_estado_bus           catalogo        = null)
with encryption
as
declare 
@w_sp_name        descripcion,
@w_return         tinyint,
@w_estado_bus     char(30),
@w_query1         char(30),
@w_query2         char(30),
@w_query3         char(30),
@w_query4         char(30),
@w_query5         char(30),
@w_query6         char(50),
@w_query7         char(50),
@w_index          char(40),
@w_operacion      char(15),
@w_estados        varchar(200),
@w_sdate          varchar(10),
@w_oficina        char(30),
@w_operacion_inc  int
        
       
select @w_sp_name = 'sp_cons_ini_operacion'
if @t_debug = 'S'
begin
   exec cobis..sp_begin_debug @t_file = @t_file
   select 
'/** Stored Procedure **/ ' = @w_sp_name,
            s_ssn                     = @s_ssn,
            s_user                    = @s_user,
            s_term                    = @s_term,
            s_date                    = @s_date,
            s_srv                     = @s_srv,
            s_lsrv                    = @s_lsrv,
            s_ofi                     = @s_ofi,
            s_rol                     = @s_rol,
            t_trn                     = @t_trn,
            t_file                    = @t_file,
            t_from                    = @t_from,
            i_num_banco         = @i_num_banco,  
            i_codigo            = @i_codigo,
            i_estado1           = @i_estado1,
            i_estado2           = @i_estado2,
            i_estado3           = @i_estado3,
            i_accion_sgte            = @i_accion_sgte,
            i_ente           = @i_ente
      exec cobis..sp_end_debug
end

/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/
if @t_trn <> 14461 and @i_operacion = 'H'
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141042
   return 1
end

--set parallel_degree 1               -- DGU-no trabaje con paralelismo, worker process
------------------------------------------------
-- Control de datos enviados desde el Front-End
------------------------------------------------
select @w_oficina = ' and op_oficina  = ' + convert(char(10), @s_ofi)
 
if @i_estado1 = '%'
   select @i_estado1 = 'nnn'
if @i_num_banco is null
   select @i_num_banco = '0'
      
if @i_num_banco <> '0'
   select @w_operacion = convert(char(15),op_operacion)
     from pf_operacion 
    where op_num_banco = @i_num_banco 
else
   select @w_operacion = '0'

if @i_codigo is null
   select @i_codigo = '%'

if @i_codigo = '%'
   select @w_query1 = ' '
else 
   select @w_query1 = ' op_num_banco = ''' + convert(char(10),@i_codigo) + ''' and '

if @i_estado1 = 'nnn' 
   select @w_query3  = '''nnn'''
else
begin
   select @w_query3  = '''' + @i_estado1 + ''''
end

if @i_estado2 = 'nnn'
   select @w_query4  = '''nnn'''
else
begin
   select @w_query4  = '''' + @i_estado2 + '''' 
end

if @i_estado3 = 'nnn'
   select @w_query5  = '''nnn'''
else
begin
   select @w_query5  = '''' + @i_estado3 + ''''
end

if @i_estado_bus is null
   select @w_estado_bus = ' '
else
   select @w_estado_bus = ' and op_estado = ''' + @i_estado_bus + ''''

if @i_estado1 = 'nnn' and @i_estado2 = 'nnn' and @i_estado3 = 'nnn' 
begin
   select @w_estados = ' '
end
else
begin
  if @i_accion_sgte in ('XREN', 'XCAN') 
  begin
     select @w_estados = ' and op_estado in (' + @w_query3 + ',' + @w_query4 +
                       ',' + @w_query5 + ' )' + ' and op_accion_sgte ='
                       + '''' +   @i_accion_sgte + ''''
  end
  else 
  begin
     if @i_estado2 = 'nnn' and @i_estado3 = 'nnn'
       select @w_estados = ' and op_estado = ''' + @i_estado1 + ''''
     else
       select @w_estados = ' and op_estado in (' + @w_query3 + ',' + @w_query4 +
                          ',' + @w_query5 + ' )'
  end
end

if @i_ente is null
begin
   select @w_query2 = ' '
end
else 
begin
   select @w_query2 = ' and op_ente  = ' + convert(char(10),@i_ente) 
end

if @i_renovada = 'S' 
   select @w_query7 = ' and op_renovada  = ' + '''S''' 
else
   select @w_query7 = ''

---------------------------------------------------------------------
-- Busqueda directa desde pf_operacion
---------------------------------------------------------------------
if @i_accion_sgte = 'INC'
begin
   set rowcount 15
   select @w_operacion_inc = convert(int,@w_operacion)
   select  '15070'= op_num_banco ,
           '14736'= op_descripcion, 
           '14737'= op_estado,
           '14738'= op_monto,
           '15756'= op_moneda,
           '14740'= op_pignorado,
           '14741'= op_monto_pgdo
    from  pf_operacion a, pf_incremento
   where  ((op_operacion > @w_operacion_inc and @i_codigo = '%')
      or  (op_num_banco = @i_codigo and @i_codigo <> '%'))
     and  op_causa_mod = 'INC'
     and  in_operacion = op_operacion
     and  in_fecha_incremento <= @s_date
     and  op_oficina = @s_ofi
     and  in_estado_inc = 'A'
     and  in_sec_incremento = (select max(in_sec_incremento) 
                                 from pf_incremento 
                                where in_operacion = a.op_operacion
                                  and in_estado_inc = 'A')
   set rowcount 0     
end

-------------------------------------------------------
-- Busqueda de operaciones con Cancelaciones Parciales
-------------------------------------------------------
if @i_accion_sgte = 'CANP'
begin
   set rowcount 15
   select @w_operacion_inc = convert(int,@w_operacion)
   select  '15070'= op_num_banco ,
           '14736'= op_descripcion, 
           '14737'= op_estado,
           '14738'= op_monto,
           '15756'= op_moneda,
           '14740'= op_pignorado,
           '14741'= op_monto_pgdo
    from  pf_operacion a, pf_cancelacion
   where  ((op_operacion > @w_operacion_inc and @i_codigo = '%')
      or  (op_num_banco = @i_codigo and @i_codigo <> '%'))
     and  op_causa_mod = 'CANP'
     and  ca_operacion = op_operacion
     and  ca_fecha_crea <= @s_date
     and  op_oficina = @s_ofi
     and  ca_estado = 'A'
     and  ca_secuencial = (select max(ca_secuencial) 
                                 from pf_cancelacion 
                                where ca_operacion = a.op_operacion
                                  and ca_estado = 'A')
   set rowcount 0     
end

-----------------------------------------------------
-- Verificar si se envio o no el codigo de operacion
-----------------------------------------------------
if @i_codigo = '%' and @i_accion_sgte <> 'INC' and @i_accion_sgte <> 'CANP'
begin
   set rowcount 15
   ---------------------------------------------------------------------
   -- Creacion de la tabla temporal para carga de todas las operaciones
   ---------------------------------------------------------------------
   create table #operac
          (op_operacion   int,
           op_num_banco   varchar(24),
           op_descripcion varchar(255),
           op_estado      char(3), 
           op_fecha_valor datetime,
           op_renovada    char(1) null,
           op_monto       money,
           op_moneda      int,
           op_pignorado   char(1),
           op_monto_pgdo  money,
           op_ente        int)
   create unique clustered index ioper on #operac ( op_operacion )

   -----------------------------------------------------   
   -- Insercion de operaciones de acuerdo a condiciones
   -----------------------------------------------------
   exec(
   'insert #operac
   select op_operacion  , op_num_banco ,
          op_descripcion, op_estado    , 
          op_fecha_valor, op_renovada,
          op_monto      , op_moneda,
          op_pignorado  , op_monto_pgdo,
          op_ente       '
   + ' from  pf_operacion'
   + ' where '
   + ' op_operacion > ' + @w_operacion
   + @w_oficina
   + @w_query2
   + @w_query7
   + @w_estados
   + @w_estado_bus)

   ----------------------------------------------
   -- Seleccion de datos para envio al Front-End
   ----------------------------------------------   
   if @i_renovada = 'N'
   begin

      exec  ('select ' + '''Num. Deposito'' = ' + '#operac.op_num_banco ,'  +
             '''Descripcion''               = ' + '#operac.op_descripcion,' +
             '''Estado''                    = ' + '#operac.op_estado,'      +
             '''Monto Total''               = ' + '#operac.op_monto,'       +
             '''Moneda''                    = ' + '#operac.op_moneda,'      +
             '''Pignorado''                 = ' + '#operac.op_pignorado,'   +
             '''Monto Pignorado''           = ' + '#operac.op_monto_pgdo,'  +
             '''Cliente''                   = ' + '#operac.op_ente'       
             + ' from  #operac'
             + ' where '
             + ' #operac.op_operacion > ' + @w_operacion )
   end
   else
   begin
      select @w_sdate = convert(varchar(10),@s_date,101)
      select @w_query6 = ' and #operac.op_fecha_valor  <= ''' + @w_sdate + ''''
      exec  ('select ' + '''Num. Deposito'' = ' + '#operac.op_num_banco ,'  +
             '''Descripcion''               = ' + '#operac.op_descripcion,' +
             '''Estado''                    = ' + '#operac.op_estado,'      +
             '''Monto Total''               = ' + '#operac.op_monto,'       +
             '''Moneda''                    = ' + '#operac.op_moneda,'      +
             '''Pignorado''                 = ' + '#operac.op_pignorado,'   +
             '''Monto Pignorado''           = ' + '#operac.op_monto_pgdo,'  +
             '''Cliente''                   = ' + '#operac.op_ente'       
             + ' from  #operac'
             + ' where '
             + ' #operac.op_operacion > ' + @w_operacion
             + ' and #operac.op_renovada = ' + '''S'''
             + @w_query6)
   end
end
else
begin
   if @i_accion_sgte <> 'INC'
   begin

      exec ('select ' + '''Num. Deposito'' = ' + 'op_num_banco ,'  +
            '''Descripcion''               = ' + 'op_descripcion,' +
            '''Estado''                    = ' + 'op_estado, '     +
            '''Monto Total''               = ' + 'op_monto,'       +
            '''Moneda''                    = ' + 'op_moneda,'      +
            '''Pignorado''                 = ' + 'op_pignorado,'   +
            '''Monto Pignorado''           = ' + 'op_monto_pgdo, ' +
            '''Cliente''                   = ' + 'op_ente'  
            + ' from  pf_operacion '
            + ' where '
            + ' op_num_banco = ''' + @i_codigo + ''''
            + @w_query2
            + @w_estados )  
   end
end
set rowcount 0
return 0
go
