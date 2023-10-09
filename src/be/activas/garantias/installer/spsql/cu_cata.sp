use cob_custodia
go

if exists(select 1 from sysobjects where name = 'sp_tablacata')
   drop proc sp_tablacata
go

create proc sp_tablacata (
   @s_date               datetime = null,	--Mar-1-99
   @t_trn                smallint = null,
   @t_from               varchar(30) = null,
   @i_producto           varchar(10)
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_retorno            int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_producto           char(10), 
   @w_codigonew          smallint,
   @w_codigoant          smallint,
   @w_codigo             smallint,
   @w_tabla              varchar(30),
   @w_descripcion        varchar(64)

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_tablacata'

/* CREACION DE TABLA TEMPORAL DE CL_TABLA */

   create table #cl_tabla(
         codigo      smallint,
         tabla       varchar(30),
         descripcion varchar(64),  
         codigonew   smallint
)

    select @w_producto = rtrim(@i_producto) + '%'

    select @w_codigonew = max(codigo +100)
    from cobis..cl_tabla
    set transaction isolation level read uncommitted

      declare cursor_tabla cursor for
      select 
      codigo, tabla, descripcion              
      from cob_custodia..cl_tabla_tmp
      where  tabla like @w_producto
      for read only

      open cursor_tabla
      fetch cursor_tabla into 
      @w_codigo, @w_tabla, @w_descripcion

      while @@fetch_status = 0
      begin
        if @@fetch_status != 0
          begin
            print 'Error'
            close cursor_tabla
            deallocate cursor_tabla
            return 1
          end

          if @@fetch_status = -1
          begin
            close cursor_tabla
            deallocate cursor_tabla
          end

          insert into #cl_tabla
          values (@w_codigo,@w_tabla,@w_descripcion,@w_codigonew)
      
          select @w_codigonew = @w_codigonew + 1

          fetch cursor_tabla into 
          @w_codigo, @w_tabla, @w_descripcion
      end   --  FIN DEL WHILE

      close cursor_tabla
      deallocate cursor_tabla
  
      insert into cobis..cl_tabla
      select codigonew,tabla,descripcion
      from  #cl_tabla

      declare cursor_1 cursor for
      select b.codigonew, b.codigo
      from #cl_tabla b
      for read only

      open cursor_1
      fetch cursor_1 into 
        @w_codigonew, @w_codigoant

      while @@fetch_status = 0
      begin
        if @@fetch_status != 0
          begin
            close cursor_1
            deallocate cursor_1
          end

        if @@fetch_status = -1
          begin
            close cursor_1
            deallocate cursor_1
          end

          update cob_custodia..cl_catalogo_tmp
          set tabla =  @w_codigonew
          where tabla = @w_codigoant
          fetch cursor_1 into 
          @w_codigonew, @w_codigoant
      end

      close cursor_1
      deallocate cursor_1

      insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
      select tabla, codigo, valor, estado
      from  cob_custodia..cl_catalogo_tmp
      order by tabla

      if @@error <> 0
         print 'error cl_catalogo:' + cast(@@error as varchar)

      insert into cobis..cl_catalogo_pro
      select 'GAR', codigo
      from   cobis..cl_tabla
      where tabla like @w_producto

      if @@error <> 0
         print 'error cl_catalogo_pro:' + cast(@@error as varchar)

      update cobis..cl_seqnos
      set siguiente = @w_codigonew
      where tabla = 'cl_tabla'

      print 'Termino Tabla y Catalogo'
      
return 0
go

