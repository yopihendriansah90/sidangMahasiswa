<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use App\Http\Resources\UserResource;

class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;
}

return response()->json([
    'message' => 'User berhasil ditambahkan',
    'data'    => new UserResource($users)
], 201);