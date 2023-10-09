/************************************************************************/
/*      Archivo           :  verifica.sp                             */
/*      Stored procedure  :  sp_verifica_existencia                     */
/*      Base de datos     :  cob_pfijo                                  */
/*      Producto          :  Plazo_fijo                                 */
/*      Realizado por     :  Johanna Chacon                             */
/*      Fecha de escritura:  05/10/2016                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este Procedimiento verifica que se ingresen operciones oficinas y   */
/*   Ciudades previamente parametrizadas en las diferentes estructuras  */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA        AUTOR                RAZON                             */
/*  05-Oct-2016  J.chacón           Emisión Inicial                     */
/************************************************************************/


USE [cob_pfijo]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select 1 from sysobjects where name = 'sp_verifica_existencia')
  drop procedure sp_verifica_existencia
go

 create procedure sp_verifica_existencia(
        @i_cadena_evaluar  varchar (250),
        @t_debug           char(1)  = 'N',
        @o_mensaje         varchar(255) = null out
 
  )
 
as
 
declare  @w_parametro  int, 
         @w_posicion  int,
         @w_token     varchar (250),
         @w_registro  varchar (max),
         @w_num   int,
         @w_sp_name   varchar(255) 


select @w_sp_name = 'sp_verifica_existencia'
select @w_registro = @i_cadena_evaluar
         
 if  @w_registro is not null
      begin 
         select @w_parametro = 0 ,@w_num =0
            while (@w_parametro < 5) 
              begin           
               select @w_parametro = @w_parametro + 1
               select @w_posicion  = charindex ('|', @w_registro) 
            
               select @w_token  = substring (@w_registro, 1, @w_posicion-1)
                if @w_parametro = 1    
                   begin --Toperacion
                     if @w_token <>''
                     Begin
                     if not exists (select 1 from cob_pfijo..pf_operacion where op_toperacion = @w_token)
                       begin
                         select  @w_num =141008
                         goto Error   
                       end
                    end
                  end                   
                if @w_parametro = 2  --Oficina
                begin
                    if @w_token <>''
                     Begin
                      if not exists (select 1 from cobis..cl_oficina where of_oficina = convert(smallint, @w_token))
                       begin                     
                         select  @w_num = 101024
                          goto Error  
                       end    
                    end
                 end
                if @w_parametro = 3 
                    begin --Ciudad
                      if @w_token <>''
                        begin
                          if not exists (select 1 from cobis..cl_ciudad where ci_ciudad = convert(int, @w_token))
                           begin 
                            select  @w_num =101016
                            goto Error  
                           end
                       end 
                    end 
                select @w_registro = substring(@w_registro, @w_posicion+1, datalength(@w_registro))
              end /* while */
end

return 0

Error:
  select @o_mensaje = mensaje 
         from  cobis..cl_errores
         where numero = @w_num
         return  @w_num





GO


