@echo off
del /f /q *.out

echo Ingreso Sp
echo ---- CREANDO SPS CEN PARA SYBASE  ... ---
echo sp_get_server_name.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_get_server_name.sp   -o %5\sp.out

echo sp_authorized_modules.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_authorized_modules.sp   -o %5\sp.out

echo sp_authorized_navigation_zone.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_authorized_navigation_zone.sp   -o %5\sp.out

echo sp_authorized_zone.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_authorized_zone.sp   -o %5\sp.out

echo sp_consult_role_exe.sp 
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_consult_role_exe.sp   -o %5\sp.out

echo sp_get_authorized_agents.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_get_authorized_agents.sp   -o %5\sp.out

echo sp_get_authorized_modules.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_get_authorized_modules.sp  -o %5\sp.out

echo sp_get_authorized_page.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_get_authorized_page.sp  -o %5\sp.out

echo sp_get_authorized_pages.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_get_authorized_pages.sp  -o %5\sp.out

echo sp_get_authorized_zones.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_get_authorized_zones.sp -o %5\sp.out

echo sp_get_autho_navi_zones.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_get_autho_navi_zones.sp -o %5\sp.out

echo sp_get_list_nodes_parents.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_get_list_nodes_parents.sp  -o %5\sp.out

echo sp_information_page.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_information_page.sp -o %5\sp.out

echo sp_label.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_label.sp -o %5\sp.out

echo sp_page.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_page.sp  -o %5\sp.out

echo sp_page_rol.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_page_rol.sp -o %5\sp.out

echo sp_prereq_page.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_prereq_page.sp -o %5\sp.out

echo sp_query_catalog_config.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_query_catalog_config.sp -o %5\sp.out

echo sp_verify_authorized_page.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_verify_authorized_page.sp  -o %5\sp.out

echo sp_cataloga_CEN.sp 
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_cataloga_CEN.sp  -o %5\sp.out

echo sp_information_page_offbanking.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_information_page_offbanking.sp  -o %5\sp.out

echo sp_perfil.sp
sqlcmd  -U%1 -P%2 -S%3   -i %4\sp_perfil.sp  -o %5\sp.out

echo -------FIN-------
