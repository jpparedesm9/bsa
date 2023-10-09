use cob_custodia
go

if exists(select 1 from sysobjects where name = 'sp_resuelve_param')
   drop proc sp_resuelve_param
go

create proc sp_resuelve_param
   @i_filial            int,
   @i_tc_tipo_bien      char(1),
   @i_tc_op_clase       char(1),
   @i_tc_moneda         int,
   @i_tc_calificacion   char(1),
   @i_tc_clase_custodia char(1),
   @i_tc_tipo           descripcion,
   @i_cuenta_orig       varchar(60),
   @o_cuenta_dest       varchar(60)  output
as
declare
   @w_parametro_ok   int,
   @w_cuenta_aux     varchar(60),
   @w_pos            int,
   @w_ascii          int,
   @w_trama          varchar(60),
   @w_clave          varchar(60),
   @w_resultado      varchar(30),
   @w_anexo          varchar(60)
begin
   -- RESOLUCION DE LA CUENTA DINAMICA
   select @w_cuenta_aux = @i_cuenta_orig
   select @w_pos = charindex('.', @w_cuenta_aux)
   
   while 0 = 0
   begin
      -- ELIMINAR PUNTOS INICIALES
      while @w_pos = 1
      begin
         select @w_cuenta_aux = substring (@w_cuenta_aux, 2, datalength(@w_cuenta_aux) - 1)
         select @w_pos = charindex('.', @w_cuenta_aux)
      end
      
      -- AISLAR SIGUIENTE PARAMETRO DEL RESTO DE LA CUENTA
      if @w_pos > 0 --existe al menos un parametro
      begin
         select @w_trama = substring (@w_cuenta_aux, 1, @w_pos-1)
         select @w_cuenta_aux = substring (@w_cuenta_aux, @w_pos+1, datalength(@w_cuenta_aux) - @w_pos)
         select @w_pos = charindex('.', @w_cuenta_aux)
      end
      ELSE
      begin
         select @w_trama = @w_cuenta_aux
         select @w_cuenta_aux = ''
      end
      
      -- CONDICION DE SALIDA DEL LAZO
      if @w_trama = '' 
         break
      
      -- VERIFICAR SI LA TRAMA ES PARTE FIJA O PARAMETRO
      select @w_ascii = ascii(substring(@w_trama, 1, 1))
      
      if @w_ascii >= 48 and @w_ascii <= 57 --NUMERICO,PARTE FIJA
      begin
         select @o_cuenta_dest = @o_cuenta_dest + @w_trama 
      end
      ELSE
      begin  --LETRA, LA TRAMA ES UN PARAMETRO
         select @w_resultado = '',
                @w_clave     = '',
                @w_parametro_ok = 0
         
         --- TIPO DE BIEN
         if 'TBN' = @w_trama
         begin
            select @w_clave = @i_tc_tipo_bien,
                   @w_parametro_ok = 1
         end
         
         --- CLASE DE CARTERA
         if 'CA' = @w_trama
         begin
            select @w_clave = @i_tc_op_clase,
                   @w_parametro_ok = 1
         end
         
         -- MONEDA
         if 'MO' = @w_trama
         begin
            select @w_clave = convert(varchar(3), @i_tc_moneda),
                   @w_parametro_ok = 1
         end
         
         --- CALIFICACION
         if 'CAL' = @w_trama
         begin
            select @w_clave = @i_tc_calificacion,
                   @w_parametro_ok = 1
         end
         
         --- CLASE DE CUSTODIA
         if 'AD' = @w_trama
         begin
            select @w_clave = @i_tc_clase_custodia,
                   @w_parametro_ok = 1
         end
         
         --- Tipo
         if 'TIP' = @w_trama
         begin
            select @w_clave = @i_tc_tipo,
                   @w_parametro_ok = 1
         end
         
         if @w_parametro_ok = 1
         begin
            select @w_resultado = re_substring
            from   cob_conta..cb_relparam 
            where  re_empresa   = @i_filial
            and    re_parametro = @w_trama
            and    re_clave     = @w_clave
            
            if @@rowcount = 0
            begin
               return 1912099
            end
         end
         ELSE
         begin
            return 1912098
         end
         select @o_cuenta_dest = @o_cuenta_dest + @w_resultado
      end
   end --fin while 0=0
   
   select @o_cuenta_dest = rtrim( ltrim(@o_cuenta_dest) )
   
   return 0
end
go

