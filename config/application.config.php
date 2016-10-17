<?php


return array(
    'modules' => array(
        'Application',
        'Auth',
        'Estrutura', //Tem que vir antes dos demais módulos
        //Para Testar: http://admin.mcnetwork.com.br/assets/compact-js/jquery.min.js,bootstrap.min.js,ie-emulation-modes-warning.js,transition.js,collapse.js
        //http://dev.catequese.com.br/assets/compact-js/jquery.min.js,bootstrap.min.js
        'CompactAsset', //Compacta o Javascript e CSS para retornar em apenas uma requisição (Responsável pela minificar o css e js: compila os arquivos em um só)
        //Ronaldo 02/03/2016 - Responsável por melhorar o desempenho da aplicação
        'Principal',
        'Perfil',
        'Config',
        'Controller',
        'Action',
        'Permissao',
        'PerfilControllerAction',
        'Infra',
        'Usuario',
        'Sexo',
        'TipoUsuario',
        'SituacaoUsuario',
        'Email',
    ),
    'module_listener_options' => array(
        'module_paths' => array(
            './module',
            './vendor',
        ),
        'config_glob_paths' => array(
            'config/autoload/{,*.}{global,' . APPLICATION_ENV . '}.php'
        ),
    )
);
