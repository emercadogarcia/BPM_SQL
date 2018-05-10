******>>>>>>>>> tarea 055 *********
declare
Flag varchar2(230);
d_org_compras varchar2(200);
v_org_compras varchar2(20);
V_RTN VARCHAR2(10);
x real;
begin
/*v_org_compras:=:tareas_menu.c_itema079;*/
/* determinar mercaderia y no mercaderia  */
SELECT o.nombre into d_org_compras FROM organizacion_compras o WHERE o.codigo_org_compras = :tareas_menu.c_itema079 AND o.codigo_empresa = '004';
flag:=substr(d_org_compras,length(d_org_compras)-12,13);
select max(numero_linea) into x from crmexpedientes_lin 
   WHERE numero_expediente = :tareas_menu.numero_expediente AND empresa = :global.codigo_empresa 
   		and codigo_secuencia='055';
/*** fin determinacion ******/
/* 50F == mercaderia; 50G== No Mercaderia*/
if flag='NO MERCADERIA' then 
	v_rtn := pkcrmexpedientes_tareas.finalizar_tarea(:global.codigo_empresa, :p_numero_expediente, x, to_char(sysdate,'dd/mm/yyyy'), 'SISTEMA', '50G', TRUE, TRUE);
       /*UPDATE crmexpedientes_lin SET status_tarea='50G'
       		WHERE numero_expediente = :p_numero_expediente
	         AND empresa = :global.codigo_empresa
	         and codigo_secuencia='055' and numero_linea = (select max(numero_linea) from crmexpedientes_lin
     		WHERE numero_expediente = :tareas_menu.numero_expediente
       		AND empresa = :global.codigo_empresa and codigo_secuencia='055');*/

  /* agregar seleccion de las UEN AQUI*/  
	V_RTN := pkcrmexpedientes_tareas.asignar_tarea_at(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, :global.usuario, null, '405304');
ELSE 
	v_rtn := pkcrmexpedientes_tareas.finalizar_tarea(:global.codigo_empresa, :p_numero_expediente, x, to_char(sysdate,'dd/mm/yyyy'), 'xSISTEMA', '50F', TRUE, TRUE);
   /*UPDATE crmexpedientes_lin SET status_tarea='50F'
       		WHERE numero_expediente = :p_numero_expediente
	         AND empresa = :global.codigo_empresa
	         and codigo_secuencia='055' and numero_linea = (select max(numero_linea) from crmexpedientes_lin
     		WHERE numero_expediente = :tareas_menu.numero_expediente
       		AND empresa = :global.codigo_empresa and codigo_secuencia='055');*/
            
	V_RTN := pkcrmexpedientes_tareas.asignar_tarea_at(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, :global.usuario, NULL, '405309');
end if;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
END;

*******  fin tarea 055 ********