import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL || 'https://szfamthbjrsqctzgokx.supabase.co';
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN6ZndudGtianJzcGNwdHpnb2tzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ1MzcxODEsImV4cCI6MjA4MDExMzE4MX0.RHng44u3pPpUZwlb-W1KvoyCi7RTVNtmw7S7LjgG0G0';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Helper para manejar errores
export function handleSupabaseError(error: any) {
  console.error('Supabase error:', error);
  return {
    error: error.message || 'Error desconocido',
    data: null
  };
}
