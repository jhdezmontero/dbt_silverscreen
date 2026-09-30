-- Standarize studio name by removing trailing spaces and punctuation and homogenize Disney and Walt Disney into Walt Disney Pictures
{% macro standarize_studio(studio_column) %}
    case 
        when trim(regexp_replace({{ studio_column }}, '\\.+$', '')) in ('Disney', 'Walt Disney') then 'Walt Disney Pictures'
        else trim(regexp_replace({{ studio_column }}, '\\.+$', ''))
    end
{% endmacro %}