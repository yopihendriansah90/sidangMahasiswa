<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mahasiswa extends Model
{
    use HasFactory;
protected $table = 'mahasiswa'; 
    protected $fillable = [
        'user_id',
        'nim',
        'jurusan',
        'alamat'
    ];
    public function user()
    {
        
        return $this->belongsTo(User::class);
    }

}
