# -*- coding: utf-8 -*-
{
    'name': "A3Tech Sale Suggest Products",

    'summary': """
       A3Tech Sugestão de Produtos em Vendas""",

    'description': """
        Módulo Que Sugere Produtos em Vendas
    """,

    'author': "Godoo",

    'category': 'Vendas',
    'version': '0.1',

    'depends': [
        'sale',
        'sale_management'
    ],

    'data': [
        'views/sale_order_views.xml'
    ],

    "installable": True,
    "application": True,
    'currency': 'BRL',
}