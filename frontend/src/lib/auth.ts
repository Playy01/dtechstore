import { supabase } from './supabase';

export interface User {
  id: number;
  email: string;
  name: string;
  role: 'user' | 'admin';
}

// Función para hashear password (simple para demo)
function simpleHash(password: string): string {
  // En producción, esto debería hacerse en el backend
  return btoa(password); // Base64 encoding simple
}

// Registrar nuevo usuario
export async function register(email: string, password: string, name: string) {
  try {
    // Verificar si el usuario ya existe
    const { data: existingUser } = await supabase
      .from('users')
      .select('email')
      .eq('email', email)
      .single();

    if (existingUser) {
      throw new Error('Este email ya está registrado');
    }

    // Crear nuevo usuario
    const { data, error } = await supabase
      .from('users')
      .insert([{
        email,
        password: simpleHash(password),
        name,
        role: 'user'
      }])
      .select()
      .single();

    if (error) throw error;

    return {
      success: true,
      user: data as User
    };
  } catch (error: any) {
    return {
      success: false,
      error: error.message || 'Error al registrar usuario'
    };
  }
}

// Iniciar sesión
export async function login(email: string, password: string) {
  try {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('email', email)
      .eq('password', simpleHash(password))
      .single();

    if (error || !data) {
      throw new Error('Email o contraseña incorrectos');
    }

    // Guardar en localStorage
    const user: User = {
      id: data.id,
      email: data.email,
      name: data.name,
      role: data.role
    };

    localStorage.setItem('user', JSON.stringify(user));
    localStorage.setItem('isLoggedIn', 'true');

    return {
      success: true,
      user
    };
  } catch (error: any) {
    return {
      success: false,
      error: error.message || 'Error al iniciar sesión'
    };
  }
}

// Cerrar sesión
export function logout() {
  localStorage.removeItem('user');
  localStorage.removeItem('isLoggedIn');
  window.location.href = '/';
}

// Obtener usuario actual
export function getCurrentUser(): User | null {
  const userStr = localStorage.getItem('user');
  if (!userStr) return null;
  
  try {
    return JSON.parse(userStr);
  } catch {
    return null;
  }
}

// Verificar si está autenticado
export function isAuthenticated(): boolean {
  return localStorage.getItem('isLoggedIn') === 'true';
}

// Verificar si es admin
export function isAdmin(): boolean {
  const user = getCurrentUser();
  return user?.role === 'admin';
}
