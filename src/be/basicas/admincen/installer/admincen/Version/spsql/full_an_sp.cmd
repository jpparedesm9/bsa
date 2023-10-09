@echo off

cd spsql
del /f /q *.out

cd..
cd

echo ---- CREANDO SPS CEN PARA SYBASE  ... ---
echo sp_component_dml.sp 
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_component_dml.sp -o %5\sp.out

echo sp_label_dml.sp 
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_label_dml.sp -o %5\sp.out

echo sp_module_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_module_dml.sp -o %5\sp.out

echo sp_module_group_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_module_group_dml.sp -o %5\sp.out

echo sp_navigation_zone_dml.sp 
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_navigation_zone_dml.sp -o %5\sp.out

echo sp_page_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_page_dml.sp -o %5\sp.out

echo sp_page_zone_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_page_zone_dml.sp -o %5\sp.out

echo sp_prereq_page_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_prereq_page_dml.sp -o %5\sp.out

echo sp_role_component_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_role_component_dml.sp -o %5\sp.out

echo sp_role_module_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_role_module_dml.sp -o %5\sp.out

echo sp_role_navigation_zone_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_role_navigation_zone_dml.sp -o %5\sp.out

echo sp_role_page_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_role_page_dml.sp -o %5\sp.out

echo sp_user_role_exe_dml.sp
sqlcmd  -U%1 -P%2 -S%3 -i %4\sp_user_role_exe_dml.sp -o %5\sp.out

cd..
echo -------FIN-------
