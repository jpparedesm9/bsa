USE cobis
GO

DECLARE @w_me_id int

IF EXISTS (SELECT 1  FROM cobis..cew_menu 
           WHERE me_url like '%iews/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.htm%')
BEGIN
    PRINT 'A'
    SELECT @w_me_id = me_id  FROM cobis..cew_menu
    WHERE me_url LIKE '%iews/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.htm%'
    
    PRINT 'Empezo a eliminar:' + convert(VARCHAR(30),@w_me_id)
    DELETE cobis..cew_menu_role WHERE mro_id_menu = @w_me_id
    
    DELETE cobis..cew_menu     
    WHERE me_url like '%iews/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.htm%'
END
GO
