<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Mahasiswa;

class MahasiswaController extends Controller
{
    // GET /api/mahasiswa
    public function index(){
        return response()->json([
            'message'=>'Daftar mahasiswa',
            'data'=> Mahasiswa::with('user')->get()
        ]);
    }

    // Get /api/mahasiwwa/{id}
    public function show($id){
        $mahasiswa = Mahasiswa::with('user')->find($id);
        if(!$mahasiswa){
            return response()->json(['message'=>'Mahasiswa tidak ditemukan','code'=>404]);
        }
        return response()->json([
                 'message' => 'Detail mahasiswa',
            'data' => $mahasiswa
        ]);
    }

    // PUT /api/mahasiswa/{id}
    public function  update(Request $request, $id){
        $mahasiswa = Mahasiwa::find($id);
        if(!$mahasiswa){
            return reponse()->json(['message'=>'Mahasiswa tidak ditemukan']);
        }

        $validated = $request->validate([
            'nim'=>'sometimes|required|string|max:20',
            'jurusan'=>'somtimes|required|string|max:255',
            'alamat'=> 'sometimes|required|string',
        ]);

        $mahasiswa->update($validated);
        return response()->json([
            'message'=>'Data mahasiswa berhasil diperbaharui',
            'data'=> $mahasiswa,
        ]);
    }

    // DELETE /api/mahasiswa/{id}
    public function destroy($id){
        $mahasiswa=Mahasiswa::find($id);
        if(!$mahasiswa){
            return response()->json(['message'=>'Mahasiswa tidak ditemukan']);

        }

        $mahasiswa->delete();
        return response()->json(['message'=>'Mahasiswa berhasil dihapus']);
    }

    // PUSH /api/mahasiswa
    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'nim'     => 'required|unique:mahasiswa,nim',
            'jurusan' => 'required|string',
            'alamat'  => 'nullable|string',
        ]);

        $mahasiswa = Mahasiswa::create($validated);

        return response()->json([
            'message' => 'Data mahasiswa berhasil ditambahkan',
            'data'    => $mahasiswa,
        ], 201);
        
    }
    
}
