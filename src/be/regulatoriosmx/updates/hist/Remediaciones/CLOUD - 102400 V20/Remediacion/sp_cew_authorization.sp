use cobis
go

if object_id('sp_cew_authorization') is not null
  begin
    drop procedure sp_cew_authorization
    if object_id('sp_cew_authorization') is not null
      print 'FAILED DROPPING PROCEDURE sp_cew_authorization'
  end
go

create procedure sp_cew_authorization(
  /************************************************************************/
  /*   Archivo:                sp_cew_authorization.sp                    */
  /*   Stored procedure:       sp_cew_authorization                       */
  /*   Base de datos:          cobis                                      */
  /*   Producto:               ADMIN-CEW                                  */
  /*   Disenado por:           Esteban Salazar                            */
  /*   Fecha de escritura:     17-Nov-2016                                */
  /************************************************************************/
  /*                             IMPORTANTE                               */
  /*   Este programa es parte de los paquetes bancarios propiedad de      */
  /*   'MACOSA', representantes exclusivos para el Ecuador de la          */
  /*   'NCR CORPORATION'.                                                 */
  /*   Su uso no autorizado queda expresamente prohibido asi como         */
  /*   cualquier alteracion o agregado hecho por alguno de sus            */
  /*   usuarios sin el debido consentimiento por escrito de la            */
  /*   Presidencia Ejecutiva de MACOSA o su representante.                */
  /************************************************************************/
  /*                     PROPOSITO                                        */
  /*   Stored Procedure que forma parte de la autorizacion del servicio   */
  /************************************************************************/
  /*                        MODIFICACIONES                                */
  /*  FECHA        VERSION  AUTOR     RAZON                               */
  /*  15/Nov/2016  1.0.0.0  ESalazar  Emision Inicial                     */
  /*  25/Oct/2018  1.0.0.1  SCH       Ajuste de borrado atomico de menus  */
  /************************************************************************/
  @i_id_menu         int,
  @i_rol             int,
  @i_rol_autorizante int,
  @i_operacion       varchar(1),
  @i_child           varchar(1) = 'S',
  @t_show_version    bit        = 0
)
as
  begin

    declare @w_menu_role_count      int,
            @w_id_parent            int,
            @w_count_menu_children  int,
            @w_return               int,
            @w_sp_name              varchar(64)

    select   @w_sp_name = 'sp_cew_authorization'

    if @t_show_version = 1
      begin
        print 'Stored procedure sp_cew_authorization, Version 1.0.0.1'
        return 0
      end
    print 'add register'
    print 'menu id:' + convert(varchar(10),@i_id_menu)
    print 'role:' + convert(varchar(10),@i_rol)

    select @w_menu_role_count = count(1)
    from cew_menu_role
    where mro_id_role = @i_rol
      and mro_id_menu = @i_id_menu

    select @w_id_parent = me_id_parent from cew_menu where me_id = @i_id_menu

    select @w_count_menu_children = count(1) from cew_menu where me_id = @i_id_menu


    if (@i_operacion = 'D')
      begin

        -- delete role authorization parent item
        if exists(select 1
                  from cobis..cew_menu
                  where me_id = @i_id_menu
                    and me_id_parent is not null)
          begin
            if not exists(select 1 from cobis..cew_menu where me_id_parent in (@i_id_menu))
              begin
                print 'delete authorization role'
                delete from cew_menu_role where mro_id_menu = @i_id_menu and mro_id_role = @i_rol
              end
          end

        -- delete role authorization parent of child
        if (@w_id_parent is not null)
          begin
            -- validate if have more children
            if not exists(
                select 1
                from cobis..cew_menu_role
                where mro_id_menu in (select me_id from cobis..cew_menu where me_id_parent = @w_id_parent
                                                                          and me_id <> @i_id_menu)
                  and mro_id_role = @i_rol
            )
              begin
                print 'delete authorization role children'
                delete
                    from cobis..cew_menu_role
                where mro_id_role not in (select mro_id_role
                                          from cobis..cew_menu_role
                                          where mro_id_menu in
                                                (select me_id from cobis..cew_menu where me_id_parent = @w_id_parent))
                  and mro_id_menu = @w_id_parent
              end
            exec @w_return = sp_cew_authorization @w_id_parent, @i_rol, @i_rol_autorizante, @i_operacion, 'N'
          end


        exec @w_return = sp_cew_authorize_resources @i_id_menu, @i_rol, @i_operacion
        exec @w_return = sp_cew_authorize_services @i_id_menu, @i_rol, @i_operacion
        exec @w_return = sp_cew_authorize_transactions @i_id_menu, @i_rol, @i_rol_autorizante, @i_operacion
        return 0
      end

    if (@w_menu_role_count = 0)
      begin

        if (@w_id_parent is null)
          begin
            if (@i_operacion = 'A')
              begin
                print 'register menu role authorization parent'
                insert into cew_menu_role (mro_id_menu, mro_id_role) values (@i_id_menu, @i_rol)
              end
            exec @w_return = sp_cew_authorize_resources @i_id_menu, @i_rol, @i_operacion
            exec @w_return = sp_cew_authorize_services @i_id_menu, @i_rol, @i_operacion
            exec @w_return = sp_cew_authorize_transactions @i_id_menu, @i_rol, @i_rol_autorizante, @i_operacion
          end
        else
          begin
            if (@i_operacion = 'A')
              begin
                print 'register menu role authorization children'
                insert into cew_menu_role (mro_id_menu, mro_id_role) values (@i_id_menu, @i_rol)
              end
            if (@i_child = 'S')
              begin
                exec @w_return = sp_cew_authorize_resources @i_id_menu, @i_rol, @i_operacion
                exec @w_return = sp_cew_authorize_services @i_id_menu, @i_rol, @i_operacion
                exec @w_return = sp_cew_authorize_transactions @i_id_menu, @i_rol, @i_rol_autorizante, @i_operacion
              end
            exec @w_return = sp_cew_authorization @w_id_parent, @i_rol, @i_rol_autorizante, @i_operacion, 'N'
          end
      end
    else
      begin

        if (@i_operacion = 'A' AND @w_id_parent is not null)
          begin
            exec @w_return = sp_cew_authorization @w_id_parent, @i_rol, @i_rol_autorizante, @i_operacion, 'N'
          end

        exec @w_return = sp_cew_authorize_resources @i_id_menu, @i_rol, @i_operacion
        exec @w_return = sp_cew_authorize_services @i_id_menu, @i_rol, @i_operacion
        exec @w_return = sp_cew_authorize_transactions @i_id_menu, @i_rol, @i_rol_autorizante, @i_operacion
      end

    return 0
  end
go