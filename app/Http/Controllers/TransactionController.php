<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TransactionController extends Controller
{
    // 🔹 Obtener todas las transacciones
    public function index()
    {
        return response()->json(DB::table('transactions')->orderBy('date', 'desc')->get());
    }

    // 🔹 Guardar una nueva transacción
    public function store(Request $request)
    {
        $this->validate($request, [
            'type' => 'required|in:income,expense',
            'category' => 'required|string|max:255',
            'amount' => 'required|numeric',
            'date' => 'required|date',
            'description' => 'nullable|string'
        ]);

        $id = DB::table('transactions')->insertGetId([
            'type' => $request->input('type'),
            'category' => $request->input('category'),
            'amount' => $request->input('amount'),
            'date' => $request->input('date'),
            'description' => $request->input('description'),
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),

        ]);

        return response()->json(['id' => $id], 201);
    }

    // 🔹 Eliminar transacción
    public function destroy($id)
    {
        DB::table('transactions')->where('id', $id)->delete();
        return response()->json(['message' => 'Eliminado']);
    }
}
