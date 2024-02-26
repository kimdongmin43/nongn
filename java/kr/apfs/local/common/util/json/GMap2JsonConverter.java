package kr.apfs.local.common.util.json;

/**
 * @Class Name : MyMapConverter.java
 * @Description : 클래스 설명을 기술합니다.
 * @author SangJoon Kim
 * @since 2011. 8. 4.
 * @version 1.0
 * @see 
 *
 * @Modification Information
 * <pre>
 *    수정일         수정자              수정내용
 *  ===========    =========    ===========================
 *  2011. 8. 4.      SangJoon Kim      최초 생성
 * </pre>
 */
import java.lang.reflect.Type;
import java.util.Map;
import java.util.Set;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

/**
 * Map의 value가 null인 경우 empty string 으로 처리 하게 
 * @author goindole
 *
 */
@SuppressWarnings({ "unchecked", "rawtypes" })
public class GMap2JsonConverter implements JsonSerializer<Map>, JsonDeserializer<Map> {

    public Map deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
        // 무시 !!
        return null;
    }

    public JsonElement serialize(Map src, Type typeOfSrc, JsonSerializationContext context) {
        JsonObject map = new JsonObject();
        Type childGenericType = null;

        for (Map.Entry entry : (Set<Map.Entry>) src.entrySet()) {
            Object value = entry.getValue();

            JsonElement valueElement;
            if (value == null) {
                valueElement = new JsonPrimitive("");
            } else {
                Type childType = (childGenericType == null) ? value.getClass() : childGenericType;
                valueElement = context.serialize(value, childType);
            }
            map.add(String.valueOf(entry.getKey()), valueElement);
        }
        return map;
    }

}