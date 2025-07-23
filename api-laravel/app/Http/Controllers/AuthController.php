<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\Controller;
use App\Models\User;

class AuthController extends Controller
{
    public function manualLogin(Request $request){
         if (!$request->expectsJson()) {
        return response()->json(['message' => 'Invalid Accept header'], 400);
    }
        // validasi input
        $request->validate([
            'email'    => 'required|email',
            'password' => 'required'
        ]);

        // cari user berdasarkan email
        $user=User::where('email',$request->email)->first();

        // apakah user ditemukan dan password cocok? 
        if(!$user|| !Hash::check($request->password, $user->password)){
            return response()->json([
                'status'=>false,
                'message'=>'Email atau password salah'
            ],401);
        }
        // jika berhasi, kirim data user
        return response()->json([
            'status'=>true,
            'message'=>'Login berhasil',
            'user'=>[
                'id'=>$user->id,
                'name'=>$user->name,
                'email'=>$user->email,
            ]
            ]);
    }

}
