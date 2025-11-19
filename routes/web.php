<?php

$router->group(['prefix' => 'api'], function () use ($router) {
    $router->get('transactions', 'TransactionController@index');
    $router->post('transactions', 'TransactionController@store');
    $router->delete('transactions/{id}', 'TransactionController@destroy');
});
