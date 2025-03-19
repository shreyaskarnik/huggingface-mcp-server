# 🤗 Hugging Face MCP Server 🤗

[![smithery badge](https://smithery.ai/badge/@shreyaskarnik/huggingface-mcp-server)](https://smithery.ai/server/@shreyaskarnik/huggingface-mcp-server)

A Model Context Protocol (MCP) server that provides read-only access to the Hugging Face Hub APIs. This server allows LLMs like Claude to interact with Hugging Face's models, datasets, spaces, papers, and collections.

## Components

### Resources

The server exposes popular Hugging Face resources:

- Custom `hf://` URI scheme for accessing resources
- Models with `hf://model/{model_id}` URIs
- Datasets with `hf://dataset/{dataset_id}` URIs
- Spaces with `hf://space/{space_id}` URIs
- All resources have descriptive names and JSON content type

### Prompts

The server provides two prompt templates:

- `compare-models`: Generates a comparison between multiple Hugging Face models
  - Required `model_ids` argument (comma-separated model IDs)
  - Retrieves model details and formats them for comparison

- `summarize-paper`: Summarizes a research paper from Hugging Face
  - Required `arxiv_id` argument for paper identification
  - Optional `detail_level` argument (brief/detailed) to control summary depth
  - Combines paper metadata with implementation details

### Tools

The server implements several tool categories:

- **Model Tools**
  - `search-models`: Search models with filters for query, author, tags, and limit
  - `get-model-info`: Get detailed information about a specific model

- **Dataset Tools**
  - `search-datasets`: Search datasets with filters
  - `get-dataset-info`: Get detailed information about a specific dataset

- **Space Tools**
  - `search-spaces`: Search Spaces with filters including SDK type
  - `get-space-info`: Get detailed information about a specific Space

- **Paper Tools**
  - `get-paper-info`: Get information about a paper and its implementations
  - `get-daily-papers`: Get the list of curated daily papers

- **Collection Tools**
  - `search-collections`: Search collections with various filters
  - `get-collection-info`: Get detailed information about a specific collection

## Configuration

The server does not require configuration, but supports optional Hugging Face authentication:

- Set `HF_TOKEN` environment variable with your Hugging Face API token for:
  - Higher API rate limits
  - Access to private repositories (if authorized)
  - Improved reliability for high-volume requests

## Quickstart

### Install

#### Installing via Smithery

To install huggingface-mcp-server for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@shreyaskarnik/huggingface-mcp-server):

```bash
npx -y @smithery/cli install @shreyaskarnik/huggingface-mcp-server --client claude
```

#### Claude Desktop

On MacOS: `~/Library/Application\ Support/Claude/claude_desktop_config.json`
On Windows: `%APPDATA%/Claude/claude_desktop_config.json`

<details>
  <summary>Development/Unpublished Servers Configuration</summary>

  ```json
  "mcpServers": {
    "huggingface": {
      "command": "uv",
      "args": [
        "--directory",
        "/absolute/path/to/huggingface-mcp-server",
        "run",
        "huggingface_mcp_server.py"
      ],
      "env": {
        "HF_TOKEN": "your_token_here"  // Optional
      }
    }
  }
  ```

</details>

## Development

### Building and Publishing

To prepare the package for distribution:

1. Sync dependencies and update lockfile:

```bash
uv sync
```

1. Build package distributions:

```bash
uv build
```

This will create source and wheel distributions in the `dist/` directory.

1. Publish to PyPI:

```bash
uv publish
```

Note: You'll need to set PyPI credentials via environment variables or command flags:

- Token: `--token` or `UV_PUBLISH_TOKEN`
- Or username/password: `--username`/`UV_PUBLISH_USERNAME` and `--password`/`UV_PUBLISH_PASSWORD`

### Debugging

Since MCP servers run over stdio, debugging can be challenging. For the best debugging
experience, we strongly recommend using the [MCP Inspector](https://github.com/modelcontextprotocol/inspector).

You can launch the MCP Inspector via [`npm`](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) with this command:

```bash
npx @modelcontextprotocol/inspector uv --directory /path/to/huggingface-mcp-server run huggingface_mcp_server.py
```

Upon launching, the Inspector will display a URL that you can access in your browser to begin debugging.

## Example Prompts for Claude

When using this server with Claude, try these example prompts:

- "Search for BERT models on Hugging Face with less than 100 million parameters"
- "Find the most popular datasets for text classification on Hugging Face"
- "What are today's featured AI research papers on Hugging Face?"
- "Summarize the paper with arXiv ID 2307.09288 using the Hugging Face MCP server"
- "Compare the Llama-3-8B and Mistral-7B models from Hugging Face"
- "Show me the most popular Gradio spaces for image generation"
- "Find collections created by TheBloke that include Mixtral models"

## Troubleshooting

If you encounter issues with the server:

1. Check server logs in Claude Desktop:
   - macOS: `~/Library/Logs/Claude/mcp-server-huggingface.log`
   - Windows: `%APPDATA%\Claude\logs\mcp-server-huggingface.log`

2. For API rate limiting errors, consider adding a Hugging Face API token

3. Make sure your machine has internet connectivity to reach the Hugging Face API

4. If a particular tool is failing, try accessing the same data through the Hugging Face website to verify it exists
