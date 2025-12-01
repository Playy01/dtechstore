import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL || 'https://szfamthbjrsqctzgokx.supabase.co';
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY || 'sb_pub813wha1e_E3haz4QlBUcrN4bfDLAKVQ_B8k3pp04';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Helper para manejar errores
export function handleSupabaseError(error: any) {
  console.error('Supabase error:', error);
  return {
    error: error.message || 'Error desconocido',
    data: null
  };
}
