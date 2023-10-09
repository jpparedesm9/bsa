update cobis..cl_seqnos set siguiente = (select isnull(max(pvi_id),0) + 1 from cob_pac..bpl_an_page_view)where tabla = 'bpl_an_page_view'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(cr_id),0) + 1 from cob_pac..bpl_condition_rule)where tabla = 'bpl_condition'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(rl_id),0) + 1 from cob_pac..bpl_rule)where tabla = 'bpl_rule'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(pr_id),0) + 1 from cob_pac..bpl_rule_process)where tabla = 'bpl_rule_process'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(pr_id),0) + 1 from cob_pac..bpl_rule_process)where tabla = 'bpl_rule_process_ejec'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(rv_id),0) + 1 from cob_pac..bpl_rule_version)where tabla = 'bpl_rule_version'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(vp_id),0) + 1 from cob_pac..bpl_variable_process)where tabla = 'bpl_variable_process'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(vp_id),0) + 1 from cob_pac..bpl_variable_process)where tabla = 'bpl_variable_process_ejec'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(vi_id),0) + 1 from cob_pac..bpl_view)where tabla = 'bpl_view'and bdatos = 'cob_pac'
update cobis..cl_seqnos set siguiente = (select isnull(max(par_id),0) + 1 from cob_pac..bpl_view_parameter)where tabla = 'bpl_view_parameter'and bdatos = 'cob_pac'

go