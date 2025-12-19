module cpurand

pub fn support() bool {
	mut result := false
	asm amd64 {
		// op dst, src
		mov eax, 1
		cpuid
		bt ecx, 30
		setc result
		; =r (result)
		; ; cc
		  eax
		  ebx
		  ecx
		  edx
	}
	return result
}

pub fn u32() u32 {
	mut result := u32(0)
	asm amd64 {
		loop:
		rdrand ecx
		jnc loop
		mov result
		ecx
		; =r (result)
		; ; cc
		  ecx
	}
	return result
}
