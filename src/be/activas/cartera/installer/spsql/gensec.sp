/************************************************************************/
/*   Archivo:          gensec.sp                                        */
/*   Stored procedure: sp_gen_sec                                       */
/*   Base de datos:    cob_cartera                                      */
/*   Producto:         Cartera                                          */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                              PROPOSITO                               */
/*   Generador de secuenciales por operacion.                           */
/*                              MODIFICACIONES                          */ 
/*   JSA: Optimizar creación de operaciones (@i_operacion = -1)         */
/************************************************************************/  
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_gen_sec')
   drop proc sp_gen_sec
go

create proc sp_gen_sec 
   @i_operacion      int =  null
as

declare @w_secuencial INT,
@w_randomico int

SELECT @i_operacion = isnull(@i_operacion, -1)

IF @i_operacion = -1
BEGIN
   SELECT @w_randomico = rand() * 100000000
   
   IF EXISTS (SELECT 1 FROM ca_sec_no_truncar WHERE randomico = @w_randomico)
   BEGIN
      DELETE ca_sec_no_truncar WHERE randomico = @w_randomico
   END
   
   INSERT INTO ca_sec_no_truncar (randomico) VALUES (@w_randomico)
   
   SELECT @w_secuencial = sec FROM ca_sec_no_truncar WHERE randomico =  @w_randomico
   
   return @w_secuencial
END
ELSE
BEGIN
   update ca_secuenciales with (rowlock) set
   @w_secuencial = se_secuencial + 1,
   se_secuencial = se_secuencial + 1
   where se_operacion = isnull(@i_operacion, -1)
   
   if @@rowcount = 0
   begin
      insert into ca_secuenciales with (rowlock) values (isnull(@i_operacion, -1), 1)
      return 1
   end
   return @w_secuencial
END

GO
