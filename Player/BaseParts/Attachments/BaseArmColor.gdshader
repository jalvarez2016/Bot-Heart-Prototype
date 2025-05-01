shader_type spatial;
uniform vec4 enemyColor : source_color = vec4(1.0);
uniform vec4 playerColor : source_color = vec4(1.0);
uniform int entityType: hint_enum("Player", "Enemy") = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (entityType == 1) {
		ALBEDO = enemyColor.rgb;
	} else if (entityType == 0) {
		ALBEDO = playerColor.rgb;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
